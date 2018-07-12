<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Panel.aspx.cs" Inherits="MagazynBaza.Panel" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Stylesheet" type="text/css" href="css/Button.css" />

    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <link href="css/dataTables.css" rel="stylesheet" />
    <script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>

    <title>Magazyn | Panel</title>
    <script>

        $(document).ready(function () {
            //$(".draggable").draggable({
            //    revert: function (event, ui) {
            //        // on older version of jQuery use "draggable"
            //        // $(this).data("draggable")
            //        // on 2.x versions of jQuery use "ui-draggable"
            //        // $(this).data("ui-draggable")
            //        $(this).data("uiDraggable").originalPosition = {
            //            top: 0,
            //            left: 0
            //        };
            //        // return boolean
            //        return !event;
            //        // that evaluate like this:
            //        // return event !== false ? false : true;
            //    }
            //});
            $(".smart").DataTable().css("width", "auto");

            $("thead *").css("width", "auto");
            
           
           

        });
        var actual = "";
        var addP = function () {
            $("#formEditProduct").toggleClass("hidden");
            $("#dark_block").toggle("fade");
            actual = "#formEditProduct";
        }
        var addT = function () {
            $("#formEditType").toggleClass("hidden");
            $("#dark_block").toggle("fade");
            actual = "#formEditType";
        }
        var addU = function () {
            $("#formEditUser").toggleClass("hidden");
            $("#dark_block").toggle("fade");
            actual = "#formEditUser";
        }


        var cancelAction = function () {
            $(actual).toggleClass("hidden");
            $(actual + " input").val("");
            $("#dark_block").toggle("fade");
        }

    </script>
    <link href="css/table.css" rel="stylesheet" />
    <style>

        @import url(https://fonts.googleapis.com/css?family=Josefin+Slab:100,300,400,600,700);
        #dark_block {
        position:fixed;
        left:0;
        top:0;
        width:100%;
        height:100%;
        z-index:99;
        background-color:rgba(0,0,0,0.5);
        display:none;
        }
        #ERROR {
            position:fixed;
            left:-4px;
            bottom:-4px;
            background:white;
            color:black;
            border: 2px solid red;
            border-radius:5px;
            z-index:1000;
        }
        .draggable {
            font: 25px;
            font-family: 'Josefin Slab', serif;
        }

        body {
            margin: 0;
            padding: 20px;
            background-color: #484848;
            min-width: 740px;
        }

        #form1 {
            position: relative;
        }

        .contener {
            max-width: 1100px;
            margin: 0 auto;
            background-color: white;
            border-radius: 5px;
            padding-top: 1px;
        }

        .user-log-out {
            z-index: 100;
            position: fixed;
            right: 0;
            top: 0;
            padding: 5px 5px 10px 10px;
            border-bottom-left-radius: 5px;
            border-bottom: 1px solid black;
            border-left: 1px solid black;
            background: rgba(255,255,255,0.8);
        }

        .user-log-out-button {
            color: #1b8fff;
            border: none;
            background: none;
            margin-left: 10px;
            cursor: pointer;
        }



        .mytable {
            width: 100% !important;
            margin: 20px 0 !important;
        }

        div.tableHold {
            position: relative;
            background-color: #E5E5E5;
            padding-left: 20px;
            padding-right: 20px;
            padding-top: 0.1px;
            padding-bottom: 20px;
        }

            div.tableHold:nth-child(2n) {
                background-color: #F2F2F2;
            }

        h1 {
            background: white;
            width: 100%;
            text-align: center;
            margin: 0;
            padding: 20px 0;
            position: sticky;
            top: 0;
            left: 0;
            z-index: 10;
            border-top-left-radius: 5px;
            border-top-right-radius: 5px;
            border-bottom: 2px solid black;
        }

        h2 {
            margin-top: 40px;
            float: left;
            /*width:300px;*/
        }

        .addCell {
            float: right;
            margin: 0;
            margin-top: 35px;
            width: 100px;
            padding: 5px;
        }

        h2:before {
            display: block;
            content: ' ';
            width: 100%;
            top: 00px;
            left: 0;
            margin-left: 0%;
            height: 2px;
            background-color: grey;
            position: absolute;
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
            opacity: 0.2;
            filter: blur(5px);
            background-repeat: no-repeat;
            transform: scale(2);
        }

       

        .formEdit {
            left: 50%;
            top: 50%;
            transform: translateX(-50%) translateY(-50%);
            padding: 20px;
            box-sizing: border-box;
            position: fixed;
            float: left;
            z-index: 100;
            background-color: burlywood;
            transition-duration:1s;
        }

            .formEdit h3 {
                font-size: 30px;
                text-align: center;
                margin-top: 0px;
            }

            .formEdit label {
                float: left;
                width: 100%;
                clear: both;
                margin: 10px 0;
                font-size: 24px;
            }

            .formEdit .input {
                color: black;
                width: 200px;
                float: right;
                padding: 5px;
                box-sizing: border-box;
            }

            .formEdit .btn {
                margin: 0;
                color: white;
            }
            .formEdit.hidden {
            top:-100%;
            }
    </style>
    
    </head>
<body>
    <div class="bg">
    </div>
     <div id="dark_block" onclick="cancelAction();">
    </div>
    


    <form id="form1"  runat="server">
        <div id="ERROR" runat="server">

        </div>
        <div id="formEditUser" runat="server" class="formEdit  hidden">
            <h3>User</h3>
            <label>Login<input class="input" id="userName" runat="server" type="text" /></label>
            <label>Password<input class="input" id="userPassword" runat="server" type="text" /></label>
            <label>Level<input class="input" id="userLevel" runat="server" min="0" max="99" type="number" /></label>
            <asp:button class="input btn btnBlueGreen" id="btnUserSave" runat="server" Text="Save" />

        </div>

        <div id="formEditType" class="formEdit hidden">
            <h3>Type</h3>
            <label>Name<input class="input" id="typeName" runat="server" type="text" /></label>
            <asp:button class="input btn btnBlueGreen" id="btnTypeSave" runat="server" Text="Save" />
        </div>

        <div  id="formEditProduct" class="formEdit  hidden">
            <h3>Product</h3>
            <label>Name<input class="input" id="productName" runat="server" type="text" /></label>
            <label>Type<asp:DropDownList CssClass="input" ID="productType" runat="server"></asp:DropDownList></label>
            <label>Quantity<input class="input" id="productQuantity" runat="server" min="0" type="number" /></label>
            <label>Value<input class="input" id="productValue" runat="server" step="0.01" min="0" type="number" /></label>
            <asp:button  class="input btn btnBlueGreen" id="btnProductSave" runat="server" Text="Save" />
        </div>



        <div class="contener">
            <div class="user-log-out">
                <asp:Label ID="lbInfoLogin"  runat="server"></asp:Label>
                <asp:Button CssClass="user-log-out-button" ID="btnLogOut" runat="server" Text="Log Out" OnClick="btnLogOut_Click" />
            </div>
            <h1>Magazyn</h1>

            <div class="tableHold">
                <h2>Products</h2>
                <button id="addCellProducts" onclick="addP();return false;" class="btn btnBlueGreen addCell">Add</button>
                <asp:PlaceHolder ID="tabProducts" runat="server"></asp:PlaceHolder>
            </div>
            <div class="tableHold">
                <h2>Types</h2>
                <button id="addCellTypes" onclick="addT();return false;" class="btn btnBlueGreen addCell">Add</button>
                <asp:PlaceHolder ID="tabTypes" runat="server"></asp:PlaceHolder>
            </div>
            <div class="tableHold">
                <asp:PlaceHolder ID="tabUsersTitle" runat="server"></asp:PlaceHolder>

                <asp:PlaceHolder ID="tabUsers" runat="server"></asp:PlaceHolder>
            </div>
        </div>
    </form>
</body>
</html>
