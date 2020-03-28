export * from "./courts.constants";
export * from "./authentication.constants";
export * from "./profile.constants";
const source = "ddns";

export const baseURL_REST_API = __config__.schema[source] + __config__.baseURL[source] + "/stkapi/";
