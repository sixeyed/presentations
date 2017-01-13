using Nest;
using ProductLaunch.MessageHandlers.IndexProspect.Documents;
using System;

namespace ProductLaunch.MessageHandlers.IndexProspect.Indexer
{
    public class Index
    {
        private static ElasticClient _Client;
        private static string _CurrentIndexSuffix;

        public static void Setup()
        {
            var node = new Uri(Config.ElasticsearchUrl);
            var settings = new ConnectionSettings(node);
            _Client = new ElasticClient(settings);
            _Client.CreateIndex("prospects");
        }        

        public static void CreateDocument(Prospect prospect)
        {
            try
            {
                var node = new Uri(Config.ElasticsearchUrl);
                var client = new ElasticClient(node);                
                client.Index(prospect, idx => idx.Index("prospects"));
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Index prospect FAILED, email address: {prospect.EmailAddress}, ex: {ex}");
            }
        }
    }
}
