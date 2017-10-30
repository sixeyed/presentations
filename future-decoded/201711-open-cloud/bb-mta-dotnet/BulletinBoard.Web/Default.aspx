<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SignUp.Web._Default" %>

<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Welcome to the Bulletin Board</h1>
    </div>

    <div class="row">
        <div class="col-md-12">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="EventsDataSource" EnableModelValidation="True">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" />
                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" SortExpression="Id" Visible="false" />
                    <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                    <asp:BoundField DataField="Detail" HeaderText="Detail" SortExpression="Detail" />
                    <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                    <asp:BoundField DataField="CreatedAt" HeaderText="CreatedAt" SortExpression="CreatedAt" Visible="false" />
                    <asp:BoundField DataField="UpdatedAt" HeaderText="UpdatedAt" SortExpression="UpdatedAt" Visible="false" />
                </Columns>
            </asp:GridView>

            <asp:EntityDataSource ID="EventsDataSource" runat="server" ConnectionString="name=BulletinBoardEntities" DefaultContainerName="BulletinBoardEntities" EnableDelete="True" EnableInsert="True" EntitySetName="Events" EntityTypeFilter="Event">
            </asp:EntityDataSource>

            <br />

            <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse">
                <tr>
                    <td style="width: 100px">Title:<br />
                        <asp:TextBox ID="txtTitle" runat="server" Width="100" />
                    </td>
                    <td style="width: 200px">Detail:<br />
                        <asp:TextBox ID="txtDetail" runat="server" Width="200" />
                    </td>
                    <td style="width: 200px">Date:<br />
                        <asp:Calendar ID="calDate" runat="server"></asp:Calendar>
                    </td>
                    <td style="width: 100px">
                        <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="Insert" />
                    </td>
                </tr>
            </table>

        </div>
    </div>

</asp:Content>
