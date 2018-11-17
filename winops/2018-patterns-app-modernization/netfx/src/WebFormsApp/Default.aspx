<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebFormsApp._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1>
            .NET WebForms App</h1>
        <h2>
            Server: <asp:Label runat="server" ID="lblServer" />
        </h2>
    </div>
    
    <hr />
    
    <h2>Logging</h2>
    <div>
    <h3>log4net config</h3>
        <asp:Table runat="server" EnableViewState="False" GridLines="Both">
            <asp:TableRow runat="server">
                <asp:TableCell runat="server">Level</asp:TableCell>
                <asp:TableCell ID="tblCellLevel" runat="server"></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow runat="server">
                <asp:TableCell runat="server">Appender</asp:TableCell>
                <asp:TableCell ID="tblCellAppender" runat="server"></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow runat="server">
                <asp:TableCell runat="server">Target</asp:TableCell>
                <asp:TableCell ID="tblCellTarget" runat="server"></asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </div>
    
    <div>
    <h3>appSettings config</h3>
        <asp:Table runat="server" EnableViewState="False" GridLines="Both">
            <asp:TableRow runat="server">
                <asp:TableCell runat="server">Log Count</asp:TableCell>
                <asp:TableCell ID="tblCellLogCount" runat="server"></asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </div>
    
    <br/>
    <div>
        <asp:Button runat="server" ID="btnLog" Text="Write Logs" OnClick="btnLog_Click" />
            &nbsp;
            <i>
            <asp:Label runat="server" ID="lblLogOutput" />
            </i>
    </div>
    
    <hr />
    
    <h2>Database Access</h2>
    
    <div>
    <h3>connectionStrings config</h3>
        <asp:Table runat="server" EnableViewState="False" GridLines="Both">
            <asp:TableRow runat="server">
                <asp:TableCell runat="server">Server Name</asp:TableCell>
                <asp:TableCell ID="tblCellSqlServer" runat="server"></asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </div>
    
    <br/>
    <div>
        <asp:Button runat="server" ID="btnSql" Text="Execute SQL" 
            onclick="btnSql_Click"/>        
            &nbsp;
            <i>
            <asp:Label runat="server" ID="lblSqlOutput" />
            </i>
            
    </div>
            
    </div>
    
    </form>
</body>
</html>
