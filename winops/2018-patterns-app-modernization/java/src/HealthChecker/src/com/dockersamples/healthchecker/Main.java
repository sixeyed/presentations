package com.dockersamples.healthchecker;

import org.apache.commons.lang3.time.StopWatch;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;

import java.io.IOException;

public class Main {

    public static void main(String[] args) throws IOException {
        int exitCode = 1;
        CloseableHttpResponse response = null;
        try {
            int timeout = 5;
            RequestConfig config = RequestConfig.custom()
                    .setConnectTimeout(timeout * 1000)
                    .setConnectionRequestTimeout(timeout * 1000)
                    .setSocketTimeout(timeout * 1000).build();
            CloseableHttpClient client = HttpClientBuilder.create().setDefaultRequestConfig(config).build();

            HttpGet httpget = new HttpGet("http://localhost:8080/");
            StopWatch stopwatch = StopWatch.createStarted();
            response = client.execute(httpget);
            stopwatch.stop();

            int statusCode = response.getStatusLine().getStatusCode();
            long elapsedMs = stopwatch.getTime();
            System.out.printf("HEALTHCHECK: status %d, took %dms%n", statusCode, elapsedMs);
            if (statusCode == 200 && elapsedMs < 150) {
                exitCode = 0;
            }
        } catch (Exception ex) {
            System.out.println("HEALTHCHECK: error. Exception " + ex.getMessage());
        }finally {
            if (response != null) {
                response.close();
            }
        }
        System.exit(exitCode);
    }
}
