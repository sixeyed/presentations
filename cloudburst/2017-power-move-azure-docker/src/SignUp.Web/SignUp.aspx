<%@ Page Title="Sign Up" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="SignUp.Web.SignUp" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Image2Docker is literally the best thing I've ever heard of!</h1>
        <p class="lead">Here are my details. Sign me up.</p>
    </div>

    <div class="form-group row">
        <div class="col-md-6">
            <label for="txtFirstName">First Name</label>
            <asp:TextBox class="form-control" id="txtFirstName" runat="server"/>
        </div>
        <div class="col-md-6">
             <label for="ddlCountry">Country</label>
            <asp:DropDownList class="form-control" id="ddlCountry" runat="server"/>
        </div>
    </div>

    <div class="form-group row">
        <div class="col-md-6">
            <label for="txtLastName">Last Name</label>
            <asp:TextBox class="form-control" id="txtLastName" runat="server"/>
        </div>
        <div class="col-md-6">
            <label for="txtCompanyName">Company Name</label>
            <asp:TextBox class="form-control" id="txtCompanyName" runat="server"/>
        </div>
    </div>

    <div class="form-group row">
        <div class="col-md-6">
            <label for="txtEmail">Email Address</label>
            <asp:TextBox class="form-control" id="txtEmail" runat="server" />
        </div>  
        <div class="col-md-6">
            <label for="ddlRole">Your Main Role</label>
            <asp:DropDownList class="form-control" id="ddlRole" runat="server" />
        </div>
    </div>

    <asp:Button class="btn btn-default" runat="server" Text="Go!" ID="btnGo" OnClick="btnGo_Click" />

</asp:Content>
