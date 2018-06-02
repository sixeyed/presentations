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
            With Logging!</h2>
    </div>
    
    <hr />
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
    
    <hr />
    <div>
    <h3>appSettings config</h3>
        <asp:Table runat="server" EnableViewState="False" GridLines="Both">
            <asp:TableRow runat="server">
                <asp:TableCell runat="server">Log Count</asp:TableCell>
                <asp:TableCell ID="tblCellLogCount" runat="server"></asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </div>
    
    <hr />
    <div>
        <asp:Button runat="server" ID="btnLog" Text="Write Logs" OnClick="btnLog_Click" />
    </div>
    </form>
</body>
</html>
