<%@ Import Namespace="System" %>
<%@ Page Language="c#"%>

<script runat="server">
    public string GetMachineName()
    {
        return Environment.MachineName;
    }
</script>

<html>
    <head>
        <style>

        body {
        	background-image: linear-gradient(-74deg, transparent 90%, rgba(255, 255, 255, 0.23) 20%), linear-gradient(-74deg, transparent 83%, rgba(255, 255, 255, 0.18) 15%), linear-gradient(-74deg, transparent 76%, rgba(255, 255, 255, 0.1) 15%), linear-gradient(to top, #127ab1, #1799e0, #1796db);
    		background-size: cover;
    		margin-bottom: 0px!important;
        }

        div{
            font-family: 'Geomanist', sans-serif;
  			font-weight: normal;
  			color: white;
            width: 85%;
            margin: 0 auto;
            position: relative;
            margin-top: 180px;
            transform: translateY(-50%);
        }

        h1{
            font-size: 50pt
        }
        h2{
            font-size: 28pt
        }
        </style>
    </head>

    <body>
        <div>
            <h1>Hello from <% =GetMachineName() %>!</h1>
        </div>
    </body>

</html>