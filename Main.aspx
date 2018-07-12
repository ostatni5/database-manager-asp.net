<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="MagazynBaza.Main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Magazan | Logowanie</title>
    <link href="css/Login.css" rel="stylesheet" />
    <style type="text/css">
        @import url(https://fonts.googleapis.com/css?family=Josefin+Slab:100,300,400,600,700);
        body {
            font-family: Arial;
            background: black;
            font-family: 'Josefin Slab', serif;
        }

        .bg {
            width: 100%;
            height: 100%;
            position: fixed;
            left: 0;
            top: 0;
            background-image: url("img/bg.jpg");
            z-index: -1;
            background-position: center center;
            opacity: 0.5;
            background-repeat: no-repeat;
        }

        h1 {
            text-align: center;
            color: white;
            font-size:50px;
            letter-spacing:2px;
        }

        input {
            padding: 5px;
            width: 100%;
            box-sizing: border-box;
            background-color: rgba(5, 71, 114, 0.2);
            color: white;
            border: 1px solid white;
            text-align: center;
        }

            input[type="submit"] {
                background-color: rgba(5, 71, 114, 0.27);
                color: white;
                font-weight: bold;
                border: 2px solid white;
            }

        .auto-style1 {
            background-color: rgba(5, 71, 114, 0.2);
            width: 400px;
            margin: 0 auto;
            color: white;
            border: 5px solid rgba(255, 255, 255, 0.6);
            padding: 0 10px;
        }

        .auto-style3 {
            width: 100%;
        }

        .auto-style4 {
            text-align: center;
        }

        .auto-style5 {
            text-align: center;
            height: 67px;
        }

        .auto-style6 {
            width: 138px;
            height: 63px;
        }

        .auto-style7 {
            height: 63px;
        }

        .auto-style8 {
            height: 54px;
        }

        .auto-style9 {
            text-align: center;
            height: 30px;
        }

        #lbInfoLogin {
            color: #FF0505;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            top: 15px;
            font-style: italic;
            letter-spacing:1px;
            z-index:100;

        }
    </style>
</head>
<body>
    <div class="bg">
    </div>

    <h1>Galaktyczny Magazyn Produktów</h1>
    <div class="login-page">
        <div class="form">
            <asp:Label ID="lbInfoLogin" runat="server"></asp:Label>

            <form class="login-form" id="form1" runat="server">
                <asp:TextBox ID="tbLogin" placeholder="username" runat="server"></asp:TextBox>
                <asp:TextBox ID="tbPass" runat="server" placeholder="password" TextMode="Password"></asp:TextBox>
                <asp:Button ID="btnLogIn" runat="server" OnClick="btnLogIn_Click" Text="Log In" />
            </form>
        </div>
    </div>
    <asp:Label ID="lbInfo1" runat="server"></asp:Label>
    <%--<form runat="server">
        <div class="auto-style3">

            <table class="auto-style1">

                <tr>
                    <td class="auto-style9" colspan="2"></td>
                </tr>
                <tr>
                    <td class="auto-style6">Login</td>
                    <td class="auto-style7">
                       
                    </td>
                </tr>
                <tr>
                    <td class="auto-style6">Password</td>
                    <td class="auto-style8">
                       
                    </td>
                </tr>
                <tr>
                    <td class="auto-style4" colspan="2">
                        
                    </td>
                </tr>
                <tr>
                    <td class="auto-style5" colspan="2">
                        <asp:Button ID="btnRegister" runat="server" Text="Register" />
                    </td>
                </tr>
            </table>
           
        </div>
    </form>--%>
</body>
</html>
