<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SignUp.Web._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Have you tried Image2Docker?</h1>
        <p class="lead">Image2Docker - tools for extracting apps from VMs into Dockerfiles.</p>
        <div style="text-align: right">
            <!-- v2 -->
            <a href="http://2017.dockercon.com/register-dockercon-2017/" target="_blank">
                <img src="img/dockercon-2017.png"/>
            </a>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            <h2>Automatically migrate apps to Docker</h2>
            <p>
                Your first step in lifting and shifting existing workloads to Docker, without changing code. Open source tools for Linux and Windows.</p>
            <p>
                Image2Docker is focused on Web workloads. You can extract LAMP apps from Linux, and ASP.NET apps from Windows - straight into Dockerfiles. </p>
            <p>
                <a class="btn btn-default" href="https://github.com/docker/communitytools-image2docker-linux" target="_blank">Check out Image2Docker for Linux</a> | 
                <a class="btn btn-default" href="https://github.com/docker/communitytools-image2docker-win" target="_blank">Check out Image2Docker for Windows</a>
            </p>
        </div>
        <div class="col-md-6">
            <h2>Interested? Get the newsletter!</h2>
            <p>
                Give us your details and we&#39;ll keep you posted.</p>
            <p>
                It only takes 30 seconds to sign up.
            </p>
            <p>
                And we probably won't spam you very much.
            </p>
            <p>
                <a class="btn btn btn-primary btn-lg" href="SignUp.aspx">Sign Up &raquo;</a>
            </p>
        </div>
    </div>

</asp:Content>
