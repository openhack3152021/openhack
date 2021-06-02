'use strict';
var Mockgen = require('../mockgen.js');
/**
 * Operations on /healthcheck/tamir
 */

module.exports = {
    /**
     * summary:
     * description: Returns healthcheck for systems looking to ensure API is up and operational
     * parameters:
     * produces:
     * responses: 200, default
     * operationId:
     */
    get: {
        200: function (req, res, callback) {
            res.json({
                message: 'healthcheck',
                status: 'healthy'
            });
            setTimeout(() => {  console.log("sleeping"); }, 500);
            callback;
        },
        default: function (req, res, callback) {
            /**
             * Using mock data generator module.
             * Replace this by actual data for the api.
             */
            Mockgen().responses({
                path: '/healthcheck/tamir',
                operation: 'get',
                response: 'default'
            }, callback);
        }
    }
};
