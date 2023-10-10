import axios from 'axios';

export const getAPI = async ( url, config) => {
    try {
        const response = await axios.get(url, config);
        return response;
    } catch (error) {
        return error;
    }
}

export const postAPI = async ( url, data, config) => {
    try {
        const response = await axios.post(url, data, config);
        return {data: response.data, error: false, status: response.status};
    } catch (error) {
        console.log(error);
        throw {error: true, data: error, status: error.response.status};
    }
}
