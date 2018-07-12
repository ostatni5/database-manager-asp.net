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

        function FindByID(id, list) {
            console.log(list)
            for (var i in list) {
                if (list[i][0] == id)
                    return list[i];
            }
        }
        function FindID(id, list) {
            console.log(list)
            for (var i in list) {
                if (list[i][1] == id)
                    return list[i][0];
            }
        }
        var list_p, list_t, list_u;
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
            list_p = JSON.parse($("#dataHolderProducts").val())
            list_t = JSON.parse($("#dataHolderTypes").val())
            



        });
        var lastSave = "";
        var actual = "";
        var block = false;
        var addP = function () {
            $("#btnProductAdd").on("click", function () {
                $("#productTypevalue").val($("#productType").val())
            })
            if (!block) {
                block = true;
                $("#formAddProduct").toggleClass("hidden");
                $("#dark_block").toggle("fade");
                $("#btnProductSave").hide();
                $("#btnProductAdd").show();


                $("#formAddProduct .toclear").attr("required", "required");
                actual = "#formAddProduct";
                lastSave = "#btnProductSave";
            }
            setTimeout(function () { block = false; }, 1000);
            $("#productType").html("");
            list_t = JSON.parse($("#dataHolderTypes").val())
            for (var i in list_t) {
                document.getElementById("productType").innerHTML += "<option value=\"" + list_t[i][0] + "\">" + list_t[i][1] + "</option>";

            }
        }
        var editP = function (id) {
            $("#btnProductSave").on("click", function () {
                $("#productTypevalue").val($("#productType").val())
            })
            if (!block) {
                block = true;
                $("#formAddProduct").toggleClass("hidden");
                $("#dark_block").toggle("fade");
                $("#btnProductSave").show();
                $("#btnProductAdd").hide();

                $("#formAddProduct .toclear").attr("required", "required");
                actual = "#formAddProduct";
                lastSave = "#btnProductSave";
            }
            setTimeout(function () { block = false; }, 1000);

            $("#editID").val(id.split("|")[1].split("_")[1]);
            var id = $("#editID").val();
            list_p = JSON.parse($("#dataHolderProducts").val())
            $("#productType").html("");
            list_t = JSON.parse($("#dataHolderTypes").val())
            for (var i in list_t)
            {
                document.getElementById("productType").innerHTML += "<option value=\"" + list_t[i][0] + "\">" + list_t[i][1] + "</option>";

             }
            var tab = FindByID(id, list_p);
            console.log(tab)
            $("#formAddProduct .toclear").each(function (index) {
                if (index +1==2)
                {
                    $(this).val(FindID(tab[index + 1],list_t));
                }
                else
                    $(this).val(tab[index + 1]);

            });
        }
        var addT = function () {
            if (!block) {
                block = true;
                $("#formAddType").toggleClass("hidden");
                $("#dark_block").toggle("fade");
                $("#btnTypeSave").hide();
                $("#btnTypeAdd").show();
                $("#tid").hide();

                $("#formAddType .toclear:not(#typeID)").attr("required", "required");
                actual = "#formAddType";
                lastSave = "#btnTypeSave";
            }
            setTimeout(function () { block = false; }, 1000);
        }
        var editT = function (id) {
            
            if (!block) {
                block = true;
                $("#formAddType").toggleClass("hidden");
                $("#dark_block").toggle("fade");
                $("#btnTypeAdd").hide();
                $("#btnTypeSave").show();
                $("#tid").show();

                $("#formAddType .toclear").attr("required", "required");
               
                actual = "#formAddType";
                lastSave = "#btnTypeSave";
            }
            setTimeout(function () { block = false; }, 1000);
           
            $("#editID").val(id.split("|")[1].split("_")[1]);
            var id = $("#editID").val();
            list_t = JSON.parse($("#dataHolderTypes").val())
            var tab = FindByID(id, list_t);
            console.log(tab)
            $("#formAddType .toclear").each(function (index) {
                $(this).val(tab[index]);
            });
        }
        var addU = function () {
            if (!block) {
                block = true;
                $("#formAddUser").toggleClass("hidden");
                $("#dark_block").toggle("fade");
                $("#btnUserSave").hide();
                $("#btnUserAdd").show();
                $("#formAddUser .toclear").attr("required", "required");
                actual = "#formAddUser";
                lastSave = "#btnUserSave";
            }
            setTimeout(function () { block = false; }, 1000);
        }
        var editU = function (id) {
            if (!block) {
                block = true;
                $("#formAddUser").toggleClass("hidden");
                $("#dark_block").toggle("fade");
                $("#btnUserAdd").hide();
                $("#btnUserSave").show();

                $("#formAddUser .toclear").attr("required", "required");
                actual = "#formAddUser";
                lastSave = "#btnUserSave";
            }
            setTimeout(function () { block = false; }, 1000);


            $("#editID").val(id.split("|")[1].split("_")[1]);
            var id = $("#editID").val();
            console.log(id)
            list_u = JSON.parse($("#dataHolderUsers").val())
            var tab = FindByID(id, list_u);
            console.log(tab)
            $("#formAddUser .toclear").each(function (index) {
                $(this).val(tab[index+1]);
            });
        }


        var cancelAction = function () {

            if (!block) {
                block = true;
                $(actual).toggleClass("hidden");
                $(".toclear").val("");
                $(".toclear").removeAttr("required");
                $("#dark_block").toggle("fade", function () {
                    setTimeout(function () { block = false; }, 10 - 000);
                });
            }

        }

    </script>
    <link href="css/table.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />
        

</head>
<body>
    <div class="bg">
    </div>
    <div id="dark_block" onclick="cancelAction();">
    </div>



    <form id="form1" runat="server">
        <input type="hidden" runat="server" id="editID" value="0" />
        <input type="hidden" runat="server" id="dataHolderUsers" value="0" />
        <input type="hidden" runat="server" id="dataHolderProducts" value="0" />
        <input type="hidden" runat="server" id="dataHolderTypes" value="0" />
        <div id="ERROR" runat="server">
        </div>
        <div id="formAddUser" runat="server" class="formEdit  hidden">
            <h3>User</h3>
            <label>Login<input class="input toclear" id="userName" runat="server" type="text" /></label>
            <label>Password<input class="input toclear" id="userPassword" runat="server" type="text" /></label>
            <label>Level<input class="input toclear" id="userLevel" runat="server" min="0" max="99" type="number" /></label>
            <asp:Button class="input btn btnBlueGreen" ID="btnUserSave" runat="server" Text="Save Current" />
            <asp:Button class="input btn btnBlueGreen" ID="btnUserAdd" runat="server" Text="Add New" />
        </div>

        <div id="formAddType" class="formEdit hidden">
            <h3>Type</h3>
            <label id="tid">ID<input class="input toclear" id="typeID" runat="server" type="text" /></label>
            <label>Name<input class="input toclear" id="typeName" runat="server" type="text" /></label>
            <asp:Button class="input btn btnBlueGreen" ID="btnTypeSave" runat="server" Text="Save Current" />
            <asp:Button class="input btn btnBlueGreen" ID="btnTypeAdd" runat="server" Text="Add New" />
        </div>

        <div id="formAddProduct" class="formEdit  hidden">
            <h3>Product</h3>
            <label>Name<input class="input toclear" id="productName" runat="server" type="text" /></label>
            <label>Type<select class="input toclear" id="productType" runat="server" EnableViewState="true"></select></label>
            <input type="hidden" id="productTypevalue" runat="server"/>
            <label>Quantity<input class="input toclear" id="productQuantity" runat="server" min="0" type="number" /></label>
            <label>Value<input class="input toclear" id="productValue" runat="server" step="0.01" min="0" type="number" /></label>
            <asp:Button class="input btn btnBlueGreen" ID="btnProductSave" runat="server" Text="Save Current" />
            <asp:Button class="input btn btnBlueGreen" ID="btnProductAdd" runat="server" Text="Add New" />
        </div>





        <div class="contener">
            <div class="user-log-out">
                <asp:Label ID="lbInfoLogin" runat="server"></asp:Label>
                <asp:Button CssClass="user-log-out-button" ID="btnLogOut" runat="server" Text="Log Out" OnClick="btnLogOut_Click" />

            </div>
            <h1>Magazyn</h1>

            <div class="tableHold">
                <h2>Products</h2>
                <button id="addCellProducts" onclick="addP();return false;" class="btn btnBlueGreen addCell" runat="server">Add</button>
                <asp:PlaceHolder ID="tabProducts" runat="server"></asp:PlaceHolder>
            </div>
            <div class="tableHold">
                <h2>Types</h2>
                <button id="addCellTypes" onclick="addT();return false;" class="btn btnBlueGreen addCell" runat="server">Add</button>
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
