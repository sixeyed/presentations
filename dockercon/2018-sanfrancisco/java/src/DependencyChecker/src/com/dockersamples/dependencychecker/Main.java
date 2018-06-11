package com.dockersamples.dependencychecker;

import com.thoughtworks.xstream.XStream;
import net.jodah.failsafe.Failsafe;
import net.jodah.failsafe.RetryPolicy;

import java.io.File;
import java.io.InputStream;
import java.net.URISyntaxException;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Main {

    private static Resource mySqlResource;

    public static void main(String[] args) throws URISyntaxException {
        loadContext();

        RetryPolicy retryPolicy = new RetryPolicy()
                .retryOn(Exception.class)
                .withMaxRetries(3);

        try {
            Failsafe.with(retryPolicy)
                    .onRetry((c, f, ctx) -> System.out.println("DEPENDENCY: Got exception, retryCount " + ctx.getExecutions()))
                    .run(() -> connectToMySql());

            System.out.println("DEPENDENCY: OK");
            System.exit(0);
        }
        catch (Exception ex) {
            System.out.println("DEPENDENCY: FAILED");
            System.exit(1);
        }
    }

    private static void loadContext() throws URISyntaxException {
        XStream xstream = new XStream();
        xstream.alias("Context", Context.class);
        xstream.aliasField("Resource", Context.class, "resource");
        xstream.alias("Resource", Resource.class);
        xstream.useAttributeFor(Resource.class, "url");
        xstream.useAttributeFor(Resource.class, "username");
        xstream.useAttributeFor(Resource.class, "password");

        Context context;
        String path = System.getenv("CONTEXT_XML_PATH");
        if (path!= null) {
            File file =new File(path);
            context = (Context) xstream.fromXML(file);
        }
        else {
            InputStream stream = Main.class.getResourceAsStream("context.xml");
            context = (Context) xstream.fromXML(stream);
        }
        mySqlResource = context.getResource();
    }

    private static void connectToMySql() throws ClassNotFoundException, IllegalAccessException, InstantiationException, SQLException {
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        String url = mySqlResource.getUrl();
        String server = url.substring(url.indexOf("://") + 3, url.indexOf(":3306")); // :)
        System.out.println("DEPENDENCY: Connecting to MySql: " + server);
        Connection conn = DriverManager.getConnection(url, mySqlResource.getUsername(), mySqlResource.getPassword());
        conn.close();
    }
}
