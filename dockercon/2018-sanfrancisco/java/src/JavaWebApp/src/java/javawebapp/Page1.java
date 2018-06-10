/*
 * Page1.java
 *
 * Created on 06-Jun-2018, 15:33:38
 */
package javawebapp;

import com.sun.rave.web.ui.appbase.AbstractPageBean;
import com.sun.webui.jsf.component.Body;
import com.sun.webui.jsf.component.Button;
import com.sun.webui.jsf.component.Form;
import com.sun.webui.jsf.component.Head;
import com.sun.webui.jsf.component.Html;
import com.sun.webui.jsf.component.Label;
import com.sun.webui.jsf.component.Link;
import com.sun.webui.jsf.component.Page;
import java.io.IOException;
import java.io.InputStream;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.faces.FacesException;
import javax.naming.NamingException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import java.text.MessageFormat;
import java.util.Properties;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import org.apache.tomcat.dbcp.dbcp.BasicDataSource;
import java.util.Random;

/**
 * <p>Page bean that corresponds to a similarly named JSP page.  This
 * class contains component definitions (and initialization code) for
 * all components that you have defined on this page, as well as
 * lifecycle methods and event handlers where you may add behavior
 * to respond to incoming events.</p>
 *
 * @author Administrator
 */
public class Page1 extends AbstractPageBean {
    // <editor-fold defaultstate="collapsed" desc="Managed Component Definition">
    /**
     * <p>Automatically managed component initialization.  <strong>WARNING:</strong>
     * This method is automatically generated, so any user-specified code inserted
     * here is subject to being replaced.</p>
     */
    private void _init() throws Exception {
    }
    private Page page1 = new Page();

    public Page getPage1() {
        return page1;
    }

    public void setPage1(Page p) {
        this.page1 = p;
    }
    private Html html1 = new Html();

    public Html getHtml1() {
        return html1;
    }

    public void setHtml1(Html h) {
        this.html1 = h;
    }
    private Head head1 = new Head();

    public Head getHead1() {
        return head1;
    }

    public void setHead1(Head h) {
        this.head1 = h;
    }
    private Link link1 = new Link();

    public Link getLink1() {
        return link1;
    }

    public void setLink1(Link l) {
        this.link1 = l;
    }
    private Body body1 = new Body();

    public Body getBody1() {
        return body1;
    }

    public void setBody1(Body b) {
        this.body1 = b;
    }
    private Form form1 = new Form();

    public Form getForm1() {
        return form1;
    }

    public void setForm1(Form f) {
        this.form1 = f;
    }
    private Button btnLog = new Button();

    public Button getBtnLog() {
        return btnLog;
    }

    public void setBtnLog(Button b) {
        this.btnLog = b;
    }

    // </editor-fold>
    private static Log log = LogFactory.getLog(Page1.class);
    private static Random random = new Random();
    private static DataSource mySqlDataSource;
    private static Integer logCount;
    private Label lblLogOutput = new Label();
    private boolean slowMode = false;

    public Label getLblLogOutput() {
        return lblLogOutput;
    }

    public void setLblLogOutput(Label l) {
        this.lblLogOutput = l;
    }
    private Label lblServer = new Label();

    public Label getLblServer() {
        return lblServer;
    }

    public void setLblServer(Label l) {
        this.lblServer = l;
    }
    private Label lblLogLevel = new Label();

    public Label getLblLogLevel() {
        return lblLogLevel;
    }

    public void setLblLogLevel(Label l) {
        this.lblLogLevel = l;
    }
    private Label lblLogAppender = new Label();

    public Label getLblLogAppender() {
        return lblLogAppender;
    }

    public void setLblLogAppender(Label l) {
        this.lblLogAppender = l;
    }
    private Label lblLogTarget = new Label();

    public Label getLblLogTarget() {
        return lblLogTarget;
    }

    public void setLblLogTarget(Label l) {
        this.lblLogTarget = l;
    }
    private Label lblDbServer = new Label();

    public Label getLblDbServer() {
        return lblDbServer;
    }

    public void setLblDbServer(Label l) {
        this.lblDbServer = l;
    }
    private Button btnSql = new Button();

    public Button getBtnSql() {
        return btnSql;
    }

    public void setBtnSql(Button b) {
        this.btnSql = b;
    }
    private Label lblSqlOutput = new Label();

    public Label getLblSqlOutput() {
        return lblSqlOutput;
    }

    public void setLblSqlOutput(Label l) {
        this.lblSqlOutput = l;
    }
    private Label lblLogCount = new Label();

    public Label getLblLogCount() {
        return lblLogCount;
    }

    public void setLblLogCount(Label l) {
        this.lblLogCount = l;
    }

    /**
     * <p>Construct a new Page bean instance.</p>
     */
    public Page1() {
    }

    /**
     * <p>Callback method that is called whenever a page is navigated to,
     * either directly via a URL, or indirectly via page navigation.
     * Customize this method to acquire resources that will be needed
     * for event handlers and lifecycle methods, whether or not this
     * page is performing post back processing.</p>
     * 
     * <p>Note that, if the current request is a postback, the property
     * values of the components do <strong>not</strong> represent any
     * values submitted with this request.  Instead, they represent the
     * property values that were saved for this view when it was rendered.</p>
     */
    @Override
    public void init() {
        // Perform initializations inherited from our superclass
        super.init();
        // Perform application initialization that must complete
        // *before* managed components are initialized
        // TODO - add your own initialiation code here

        // <editor-fold defaultstate="collapsed" desc="Managed Component Initialization">
        // Initialize automatically managed components
        // *Note* - this logic should NOT be modified
        try {
            _init();
        } catch (Exception e) {
            log("Page1 Initialization Failure", e);
            throw e instanceof FacesException ? (FacesException) e : new FacesException(e);
        }

    // </editor-fold>
    // Perform application initialization that must complete
    // *after* managed components are initialized
    // TODO - add your own initialization code here
    }

    /**
     * <p>Callback method that is called after the component tree has been
     * restored, but before any event processing takes place.  This method
     * will <strong>only</strong> be called on a postback request that
     * is processing a form submit.  Customize this method to allocate
     * resources that will be required in your event handlers.</p>
     */
    @Override
    public void preprocess() {
    }

    /**
     * <p>Callback method that is called just before rendering takes place.
     * This method will <strong>only</strong> be called for the page that
     * will actually be rendered (and not, for example, on a page that
     * handled a postback and then navigated to a different page).  Customize
     * this method to allocate resources that will be required for rendering
     * this page.</p>
     */
    @Override
    public void prerender() {

        try {
            this.slowMode = random.nextInt(10) > 6;
            if (this.slowMode) {
                Thread.sleep(200);
            }
            this.SetLabelText(slowMode);
        } catch (Exception ex) {
        }
    }

    private void SetLabelText(boolean slowMode) throws UnknownHostException, IOException, NamingException {

        this.lblServer.setText(InetAddress.getLocalHost().getHostName());
        if (slowMode) {
            this.lblServer.setText(this.lblServer.getText() + " [SLOW MODE]");
        }

        //log config
        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
        InputStream input = classLoader.getResourceAsStream("logging.properties");
        Properties properties = new Properties();
        properties.load(input);
        String handlers = properties.getProperty("handlers");
        this.lblLogAppender.setText(handlers);
        if (handlers.indexOf("java.util.logging.FileHandler") > -1) {
            this.lblLogLevel.setText(properties.getProperty("java.util.logging.FileHandler.level"));
            this.lblLogTarget.setText(properties.getProperty("java.util.logging.FileHandler.pattern"));
        }

        //app config: 
        Context initialContext = new InitialContext();
        Context envContext = (Context) initialContext.lookup("java:/comp/env");
        logCount = (Integer) envContext.lookup("LogCount");
        this.lblLogCount.setText(logCount.toString());

        //database config:            
        mySqlDataSource = (DataSource) envContext.lookup("jdbc/mysql");
        BasicDataSource bds = (BasicDataSource) mySqlDataSource;
        String url = bds.getUrl();
        String server = url.substring(url.indexOf("://") + 3, url.indexOf(":3306"));
        this.lblDbServer.setText(server);

    }

    /**
     * <p>Callback method that is called after rendering is completed for
     * this request, if <code>init()</code> was called (regardless of whether
     * or not this was the page that was actually rendered).  Customize this
     * method to release resources acquired in the <code>init()</code>,
     * <code>preprocess()</code>, or <code>prerender()</code> methods (or
     * acquired during execution of an event handler).</p>
     */
    @Override
    public void destroy() {
    }

    /**
     * <p>Return a reference to the scoped data bean.</p>
     *
     * @return reference to the scoped data bean
     */
    protected SessionBean1 getSessionBean1() {
        return (SessionBean1) getBean("SessionBean1");
    }

    /**
     * <p>Return a reference to the scoped data bean.</p>
     *
     * @return reference to the scoped data bean
     */
    protected RequestBean1 getRequestBean1() {
        return (RequestBean1) getBean("RequestBean1");
    }

    /**
     * <p>Return a reference to the scoped data bean.</p>
     *
     * @return reference to the scoped data bean
     */
    protected ApplicationBean1 getApplicationBean1() {
        return (ApplicationBean1) getBean("ApplicationBean1");
    }

    public String btnLog_action() {
        for (int i = 1; i <= logCount; i++) {
            log.debug(MessageFormat.format("Debug log {0}", i));
            log.info(MessageFormat.format("Info log {0}", i));
            log.warn(MessageFormat.format("Warn log {0}", i));
            log.error(MessageFormat.format("Error log {0}", i));
            log.fatal(MessageFormat.format("Fatal log {0}", i));
        }
        this.lblLogOutput.setText(MessageFormat.format("Wrote {0} log entries", logCount));

        return null;
    }

    public String btnSql_action() throws SQLException {
        Connection conn = mySqlDataSource.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT SYSDATE() FROM DUAL;");
        if (rs.next()){
            Date dbDate = rs.getDate(0);
            this.lblSqlOutput.setText(dbDate.toString());
        }
        conn.close();
        
        return null;
    }
}
