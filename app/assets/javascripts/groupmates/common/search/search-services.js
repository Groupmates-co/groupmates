(function() {
'use strict';

angular
  .module('groupmates.search.services',['elasticsearch'])
  .factory("SearchService", SearchService);
  
  SearchService.$inject = ['$q', 'esFactory', '$location'];

  function SearchService ($q, esFactory, $location) {
    var client = esFactory({
      host: $location.host()+':9200'
    });

    /**
     * Given a term and an offset, load another round of 10 recipes.
     *
     * Returns a promise.
     */
    var search = function(query, offset, filters) {
      var deferred = $q.defer();
      var query = {
        match: {
          _all: query
        }
      };

      // switch (expression) {
      //   case value1:
      //   //Statements executed when the result of expression matches value1
      //   break;
      //   default:
      //     //Statements executed when none of the values match the value of the expression
      //   break;
      // }

   
      client.search({
        index: 'messages',
        type: 'message',
        body: {
          size: 10,
          from: (offset || 0) * 10,
          query: query
        }
      }).then(function(result) {
        var ii = 0, hits_in, hits_out = [];
   
        hits_in = (result.hits || {}).hits || [];
   
        for(; ii < hits_in.length; ii++) {
          hits_out.push(hits_in[ii]._source);
        }
   
        deferred.resolve(hits_out);
      }, deferred.reject);
   
      return deferred.promise;
    };
 
    // Since this is a factory method, we return an object representing the actual service.
    return {
      search: search
    };
  }

})();