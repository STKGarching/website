/****************************
Packages
****************************/
var fs = require("fs");
var path = require("path");
var _ = require("lodash");
var minimist = require("minimist");
var chalk = require("chalk");
var yaml = require("js-yaml");
/****************************
Plugins
****************************/
const BundleAnalyzerPlugin = require("webpack-bundle-analyzer")
  .BundleAnalyzerPlugin;
const CleanWebpackPlugin = require("clean-webpack-plugin");
const Dotenv = require("dotenv-webpack");
const HtmlWebPackPlugin = require("html-webpack-plugin");
const SpeedMeasurePlugin = require("speed-measure-webpack-plugin");
const webpack = require("webpack");
//const UglifyWebpackPlugin = require("uglifyjs-webpack-plugin");

/****************************
Implement Modules
****************************/
const moduleObj = {
  rules: [
    {
      test: /\.(js|jsx)$/,
      exclude: /node_modules/,
      use: {
        loader: "babel-loader"
      }
    },
    {
      test: /\.html$/,
      use: [
        {
          loader: "html-loader",
          options: { minimize: true }
        }
      ]
    },
    {
      test: /\.(scss|css)$/,
      use: [
        {
          loader: "style-loader" // creates style nodes from JS strings
        },
        {
          loader: "css-loader", // translates CSS into CommonJS
          options: {
            sourceMap: true,
            modules: true,
            //localIdentName: "[name]__[local]___[hash:base64:5]"
            localIdentName: "[local]"
          }
        },
        {
          loader: "sass-loader" // compiles Sass to CSS
          //options: { sourceMap: true }
        }
      ]
    },
    {
      test: /\.(jpg|png)$/,
      use: {
        loader: "file-loader",
        options: {
          name: "[name].png"
        }
      }
    }
  ]
};

/****************************
Basic Config
****************************/
const smp = new SpeedMeasurePlugin();

// Wifi 
var myEnv = minimist(process.argv.slice(2)).ENV;
if (!myEnv) {
  console.log(chalk.bold.red("No Environment provided! Add Argument with --ENV=YourENV\n"));
  console.log(chalk.bold.red("Check also confg.yaml!\n\n"));
  process.exit(1);
}
console.log("My Environment: " + myEnv)
// Source: Local or DDNS
var source = minimist(process.argv.slice(2)).SOURCE;
if (!source) {
  source = "local"
}
console.log("SOURCE: " + source)

// Read Config.yaml
var env = {};
try {
  var config = yaml.safeLoad(fs.readFileSync("../config.yaml", "utf8"));
  config.env.forEach(realEnv => {
    if (realEnv.env === myEnv) {
      env = realEnv;
    }
  });
  env.auth0 = config.auth0[myEnv][source];
} catch (e) {
  console.log(e);
}

var DEFAULT_TARGET = "BUILD";

/****************************
Webpack Options
****************************/
// Generel parameter configuration for every webpack build
var DEFAULT_PARAMS = {
  resolve: {
    extensions: [".js"]
  },

  entry: [
    "webpack-dev-server/client?http://" + env.baseURL[source] + "/",
    "webpack/hot/only-dev-server",
    path.resolve(__dirname, "client/app/index.js")
  ],
  target: "web",
  output: {
    filename: "index.js",
    path: path.resolve(__dirname, "dist/public")
  },
  module: moduleObj,
  plugins: [
    new HtmlWebPackPlugin({
      template: "client/app/index.html"
    }),
    new Dotenv(),
    new webpack.DefinePlugin({ __config__: JSON.stringify(env) })
  ]
};

// Special Parameters: Depending on args TARGET
var PARAMS_PER_TARGET = {
  DEV: {
    devtool: "source-map",
    output: {
      filename: "index.js"
    },
    mode: "development",
    optimization: {
      minimize: false
    },
    plugins: [
      new CleanWebpackPlugin(["dist/public"]),
      new BundleAnalyzerPlugin({ analyzerMode: "disabled" })
    ]
  },

  DEV_SERVER: {
    devtool: "source-map",
    output: {
      filename: "index.js",
      publicPath: "/"
    },
    mode: "development",
    devServer: {
      disableHostCheck: true,
      publicPath: "/",
      host: "127.0.0.1",
      port: 9000,
      https: false,
      headers: {
        "Access-Control-Allow-Origin": "*"
      },
      //historyApiFallback: true
    }
  },

  BUILD: {
    entry: path.resolve(__dirname, "client/app/index.js"),
    output: {
      path: path.join(__dirname, env.buildPath)
    },
    devtool: "source-map",
    mode: "production",
    plugins: [new CleanWebpackPlugin(), new HtmlWebPackPlugin({
      hash: true,
      filename: path.join(__dirname, env.buildPath, "/index.html")
    })
    ]
  }
};

// Merge Default Parameters with speical parameters
var target = _resolveBuildTarget(DEFAULT_TARGET);
var params = _.merge(
  DEFAULT_PARAMS,
  PARAMS_PER_TARGET[target],
  _mergeArraysCustomizer
);

// Console Output
_printBuildInfo(target, params);
// Webpack execution
module.exports = smp.wrap(params);


// Help Functions
// Get Target from args of command line
function _resolveBuildTarget(defaultTarget) {
  var target = minimist(process.argv.slice(2)).TARGET;
  if (!target) {
    console.log("No build target provided, using default target instead\n\n");
    target = defaultTarget;
  }
  return target;
}

// Write Console Output Function
function _printBuildInfo(target, params) {
  console.log("\nStarting " + chalk.bold.green('"' + target + '"') + " build");
  if (target === "DEV_SERVER") {
    console.log(
      "Dev server: " +
      chalk.bold.yellow(
        "http://localhost:" + params.devServer.port + "/lokal"
      ) +
      "\n\n"
    );
  } else {
    console.log(chalk.bold.red("Webpack Parameter"));
    console.log(chalk.bold.red("---------------------------------"));
    console.log(params);
    console.log(chalk.bold.red("---------------------------------"));
  }
}

// Merge Arrays
function _mergeArraysCustomizer(a, b) {
  if (_.isArray(a)) {
    return a.concat(b);
  }
}
