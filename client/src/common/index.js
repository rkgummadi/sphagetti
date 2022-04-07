const axios = require("axios");



export const axiosGet = async (url) => {
  try {
    let resp = await axios.get(url);
    console.log("axios Get ", resp);
    return await resp.data;
  } catch (err) {
    const errorString =
      "Error in API GET request URL " + url + " . Actual Request Error " + err;
    console.log(errorString);
  }
};

export const axiosPost = async (url, body) => {
  try {
    let resp = await axios.post(url, body);
    console.log("axios Post ", resp);
    return await resp.data;
  } catch (err) {
    const errorString =
      "Error in API POST request URL " +
      url +
      " with POST Body " +
      body +
      ". Actual Request Error " +
      err;
    console.log(errorString);
  }
};
