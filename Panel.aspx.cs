using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace MagazynBaza
{
    public partial class Panel : System.Web.UI.Page
    {
        int level = 99;
        public Table ConvertDataTableToHTML(DataTable dt, string prefix)
        {


            Table table = new Table();
            table.Attributes.Add("Class", "draggable mytable smart");
            table.Attributes.Add("Id", "table_" + prefix);

            // Set the table's formatting-related properties.
            // table1.Border = 1;
            // table1.CellPadding = 3;
            // table1.CellSpacing = 3;
            // table1.BorderColor = "black";

            TableRow row;
            TableCell cell;
            row = new TableRow();
            row.TableSection = TableRowSection.TableHeader;
            for (int i = 0; i < dt.Columns.Count; i++)
            {

                // Create a cell and set its text.
                cell = new TableHeaderCell();

                cell.Text = dt.Columns[i].ColumnName;
                // Add the cell to the current row.
                row.Cells.Add(cell);
            }
            if (level < 2)
            {
                cell = new TableHeaderCell();

                cell.Text = "Actions";
                // Add the cell to the current row.
                row.Cells.Add(cell);
            }
            table.Rows.Add(row);

            //add rows
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                row = new TableRow();

                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    // Create a cell and set its text.
                    cell = new TableCell();
                    cell.Text = dt.Rows[i][j].ToString();
                    // Add the cell to the current row.
                    row.Cells.Add(cell);
                }
                if (level < 2)
                {
                    Button btnDelete = new Button();
                    btnDelete.CssClass = "btnFloat btn btnNiceRed";
                    btnDelete.Text = "Delete";
                    btnDelete.ID = prefix + "|delete_" + dt.Rows[i][0].ToString();

                    btnDelete.Click += new EventHandler(btnDelete_Click);

                    Button btnEdit = new Button();
                    btnEdit.CssClass = "btnFloat btnOrange btn";
                    btnEdit.Text = "Edit";
                    if (prefix == "products")
                        btnEdit.OnClientClick = "editP(this.id);return false;";
                    if (prefix == "users")
                        btnEdit.OnClientClick = "editU(this.id);return false;";
                    if (prefix == "types")
                        btnEdit.OnClientClick = "editT(this.id);return false;";
                    btnEdit.ID = prefix + "|edit_" + dt.Rows[i][0].ToString();
                    btnEdit.Click += new EventHandler(btnEdit_Click);

                    cell = new TableCell();
                    cell.Controls.Add(btnDelete);
                    cell.Controls.Add(btnEdit);
                    row.Cells.Add(cell);
                }
                table.Rows.Add(row);

            }

            return table;
        }


        List<string[]> lista_p = new List<string[]>();
        List<string[]> lista_u = new List<string[]>();
        List<string[]> lista_t = new List<string[]>();
        string myconnection = "SERVER=localhost;DATABASE=magazyn;UID=root;";
        protected void Page_Load(object sender, EventArgs e)
        {

            //if (IsPostBack)
            //{
            //    productType.Value = Request.Form[productType.UniqueID];
            //}
            //productType.EnableViewState = true;
            //string json = JsonConvert.SerializeObject(lista_p);
            string user_name = (string)(Session["user_name"]);
            string user_level = (string)(Session["user_level"]);
            if(user_level != null&& user_level != "")
            level = Int32.Parse(user_level);
            if (user_name == "error" || user_name == null)
            {
                Server.Transfer("Main.aspx", true);
            }
            else
            {

                lbInfoLogin.Text = user_name;

                MySqlConnection connetion = new MySqlConnection(myconnection);
                try
                {
                    connetion.Open();

                    //PRODUCTS
                    MySqlCommand command = connetion.CreateCommand();
                    command.CommandText = "SELECT products.id,products.name,types.name,products.quantity,products.value FROM products LEFT JOIN types ON products.type_id = types.id";
                    MySqlDataReader reader = command.ExecuteReader();
                    var dt = new DataTable();
                    //AddColumns                    
                    dt.Columns.Add("ID");
                    dt.Columns.Add("Name");
                    dt.Columns.Add("Type");
                    dt.Columns.Add("Quantity");
                    dt.Columns.Add("Value");


                    //LoadData
                    int i = 1;
                    while (reader.Read())
                    {
                        string[] tab = { reader[0].ToString(), reader[1].ToString(), reader[2].ToString(), reader[3].ToString(), reader[4].ToString() };
                        lista_p.Add(tab);
                        i++;
                    }
                    reader.Close();
                    for (int r = 0; r < lista_p.Count; r++)
                        dt.LoadDataRow(lista_p[r], true);
                    tabProducts.Controls.Add(ConvertDataTableToHTML(dt, "products"));//podmaina place holdera
                    dataHolderProducts.Value = JsonConvert.SerializeObject(lista_p);
                    //TYPES
                    command = connetion.CreateCommand();
                    command.CommandText = "SELECT * FROM types";
                    reader = command.ExecuteReader();
                    dt = new DataTable();
                    //AddColumns                    
                    dt.Columns.Add("ID");
                    dt.Columns.Add("Name");

                    //LoadData
                    i = 1;
                    while (reader.Read())
                    {
                        string[] tab = { reader[0].ToString(), reader[1].ToString() };
                        lista_t.Add(tab);
                        i++;
                    }
                    reader.Close();


                    productType.Items.Clear();
                    for (int r = 0; r < lista_t.Count; r++)
                    {
                        dt.LoadDataRow(lista_t[r], true);

                        //if (!Page.IsPostBack)
                        // productType.Items.Insert(r, new ListItem(lista_t[r][1], lista_t[r][0]));
                    }

                    tabTypes.Controls.Add(ConvertDataTableToHTML(dt, "types"));//podmaina place holdera 
                    dataHolderTypes.Value = JsonConvert.SerializeObject(lista_t);
                    //USERS
                    if (user_level == "0")
                    {
                        command = connetion.CreateCommand();
                        command.CommandText = "SELECT * FROM users WHERE login<>'admin'";
                        reader = command.ExecuteReader();
                        dt = new DataTable();
                        //AddColumns                    
                        dt.Columns.Add("ID");
                        dt.Columns.Add("Login");
                        dt.Columns.Add("Password");
                        dt.Columns.Add("Level");

                        //LoadData
                        i = 1;
                        while (reader.Read())
                        {
                            string[] tab = { reader[0].ToString(), reader[1].ToString(), reader[2].ToString(), reader[3].ToString() };
                            lista_u.Add(tab);
                            i++;
                        }
                        reader.Close();

                        for (int r = 0; r < lista_u.Count; r++)
                            dt.LoadDataRow(lista_u[r], true);

                        tabUsersTitle.Controls.Add(new LiteralControl(("<h2>Users</h2> <button id=\"addCellUsers\" onclick=\"addU(); return false; \" class=\"btn btnBlueGreen addCell\"  >Add</button>")));//podmaina place holdera
                        tabUsers.Controls.Add(ConvertDataTableToHTML(dt, "users"));//podmaina place holdera
                        dataHolderUsers.Value = JsonConvert.SerializeObject(lista_u);
                    }
                    else
                    {
                        formAddUser.InnerHtml = "";
                        formAddUser.Attributes.Clear();
                    }


                }
                catch (MySql.Data.MySqlClient.MySqlException ex)
                {
                    ERROR.InnerHtml = ex.ToString();
                }
            }


            btnTypeAdd.Click += new EventHandler(btnTypeAdd_Click);
            btnUserAdd.Click += new EventHandler(btnUserAdd_Click);
            btnProductAdd.Click += new EventHandler(btnProductAdd_Click);
            btnProductSave.Click += new EventHandler(btnProductSave_Click);
            btnTypeSave.Click += new EventHandler(btnTypeSave_Click);
            btnUserSave.Click += new EventHandler(btnUserSave_Click);
            if (level > 2)
            {
                addCellProducts.Attributes.Add("style", "display:none;");
                addCellTypes.Attributes.Add("style", "display:none;");
            }

        }

        protected void btnProductAdd_Click(object sender, EventArgs e)
        {
            if (productName.Value.Trim() != null && productName.Value.Trim() != " " && productName.Value.Trim() != "")
                if (productTypevalue.Value != null && productTypevalue.Value != "0" && productTypevalue.Value != "")
                {
                    if (productQuantity.Value.Trim() != null && productQuantity.Value.Trim() != " " && productQuantity.Value.Trim() != "")
                        if (productValue.Value.Trim() != null && productValue.Value.Trim() != " " && productValue.Value.Trim() != "")
                        {
                            MySqlConnection connetion = new MySqlConnection(myconnection);
                            try
                            {
                                connetion.Open();

                                //PRODUCTS
                                MySqlCommand command = connetion.CreateCommand();
                                command.Parameters.AddWithValue("@productName", productName.Value);
                                command.Parameters.AddWithValue("@productType", productTypevalue.Value);
                                command.Parameters.AddWithValue("@productQuantity", productQuantity.Value);
                                command.Parameters.AddWithValue("@productValue", productValue.Value);
                                command.CommandText = "INSERT INTO products (name,type_id,quantity,value) VALUES(@productName,@productType,@productQuantity,@productValue); ";
                                MySqlDataReader reader = command.ExecuteReader();
                                Response.Redirect(Request.RawUrl);
                                connetion.Close();
                            }
                            catch (Exception ex)
                            {
                                ERROR.InnerHtml = ex.ToString();
                            }
                        }
                }
                else
                {
                    ERROR.InnerHtml = "ERROR:       Zły typ !!!!!! {0}";
                }


        }

        protected void btnProductSave_Click(object sender, EventArgs e)
        {
            if (productTypevalue.Value != null && productTypevalue.Value != "0" && productTypevalue.Value != "")
                if (productName.Value.Trim() != null && productName.Value.Trim() != " " && productName.Value.Trim() != "")
                    if (productQuantity.Value.Trim() != null && productQuantity.Value.Trim() != " " && productQuantity.Value.Trim() != "")
                        if (productValue.Value.Trim() != null && productValue.Value.Trim() != " " && productValue.Value.Trim() != "")
                        {
                            MySqlConnection connetion = new MySqlConnection(myconnection);
                            try
                            {
                                connetion.Open();

                                //PRODUCTS
                                MySqlCommand command = connetion.CreateCommand();
                                command.Parameters.AddWithValue("@productName", productName.Value);
                                command.Parameters.AddWithValue("@productType", productTypevalue.Value);
                                command.Parameters.AddWithValue("@productQuantity", productQuantity.Value);
                                command.Parameters.AddWithValue("@productValue", productValue.Value);
                                command.Parameters.AddWithValue("@ID", editID.Value);
                                command.CommandText = "UPDATE products SET name=@productName, type_id=@productType, quantity=@productQuantity, value=@productValue WHERE id = @ID; ";
                                MySqlDataReader reader = command.ExecuteReader();
                                Response.Redirect(Request.RawUrl);
                                connetion.Close();
                            }
                            catch (Exception ex)
                            {
                                ERROR.InnerHtml = ex.ToString();
                            }
                        }


        }
        protected void btnTypeAdd_Click(object sender, EventArgs e)
        {
            if (typeName.Value.Trim() != null && typeName.Value.Trim() != " " && typeName.Value.Trim() != "")
            {
                MySqlConnection connetion = new MySqlConnection(myconnection);
                try
                {
                    connetion.Open();

                    //PRODUCTS
                    MySqlCommand command = connetion.CreateCommand();
                    command.Parameters.AddWithValue("@typeName", typeName.Value);
                    command.CommandText = "INSERT INTO types (name) VALUES(@typeName); ";
                    MySqlDataReader reader = command.ExecuteReader();
                    Response.Redirect(Request.RawUrl);
                    connetion.Close();
                }
                catch (Exception ex)
                {
                    ERROR.InnerHtml = ex.ToString();
                }
            }


        }
        protected void btnTypeSave_Click(object sender, EventArgs e)
        {
            if (typeName.Value.Trim() != null && typeName.Value.Trim() != " " && typeName.Value.Trim() != "")
                if (typeID.Value.Trim() != null && typeID.Value.Trim() != " " && typeID.Value.Trim() != "")
                {
                MySqlConnection connetion = new MySqlConnection(myconnection);
                try
                {
                    connetion.Open();

                    //PRODUCTS
                    MySqlCommand command = connetion.CreateCommand();
                    command.Parameters.AddWithValue("@typeName", typeName.Value);
                    command.Parameters.AddWithValue("@typeID", typeID.Value);
                        command.Parameters.AddWithValue("@ID", editID.Value);

                    command.CommandText = "UPDATE types SET id=@typeID, name=@typeName WHERE id = @ID;  ";

                    MySqlDataReader reader = command.ExecuteReader();
                    Response.Redirect(Request.RawUrl);
                    connetion.Close();
                }
                catch (Exception ex)
                {
                    ERROR.InnerHtml = ex.ToString();
                }
            }


        }


        protected void btnUserAdd_Click(object sender, EventArgs e)
        {
            if (userName.Value.Trim() != null && userName.Value.Trim() != " " && userName.Value.Trim() != "")
                if (userPassword.Value.Trim() != null && userPassword.Value.Trim() != " " && userPassword.Value.Trim() != "")
                    if (userLevel.Value.Trim() != null && userLevel.Value.Trim() != " " && userLevel.Value.Trim() != "")
                    {
                        MySqlConnection connetion = new MySqlConnection(myconnection);
                        try
                        {
                            connetion.Open();

                            //PRODUCTS
                            MySqlCommand command = connetion.CreateCommand();
                            command.Parameters.AddWithValue("@userName", userName.Value);
                            command.Parameters.AddWithValue("@userPassword", userPassword.Value);
                            command.Parameters.AddWithValue("@userLevel", userLevel.Value);
                            command.CommandText = "INSERT INTO users (login,pass,level) VALUES(@userName,SHA1(@userPassword),@userLevel); ";
                            MySqlDataReader reader = command.ExecuteReader();
                            Response.Redirect(Request.RawUrl);
                            connetion.Close();
                        }
                        catch (Exception ex)
                        {
                            ERROR.InnerHtml = ex.ToString();
                        }
                    }


        }
        protected void btnUserSave_Click(object sender, EventArgs e)
        {
            if (userName.Value.Trim() != null && userName.Value.Trim() != " " && userName.Value.Trim() != "")
            {
                if (userPassword.Value.Trim() != null && userPassword.Value.Trim() != " " && userPassword.Value.Trim() != "")
                {
                    if (userLevel.Value.Trim() != null && userLevel.Value.Trim() != " " && userLevel.Value.Trim() != "")
                    {
                        MySqlConnection connetion = new MySqlConnection(myconnection);
                        try
                        {
                            connetion.Open();

                            //PRODUCTS
                            MySqlCommand command = connetion.CreateCommand();
                            command.Parameters.AddWithValue("@userName", userName.Value);
                            command.Parameters.AddWithValue("@userPassword", userPassword.Value);
                            command.Parameters.AddWithValue("@userLevel", userLevel.Value);
                            command.Parameters.AddWithValue("@ID", editID.Value);
                            command.CommandText = "UPDATE users SET login=@userName, pass=@userPassword, level=@userLevel WHERE id = @ID;  ";
                            MySqlDataReader reader = command.ExecuteReader();
                            Response.Redirect(Request.RawUrl);
                            connetion.Close();
                        }
                        catch (Exception ex)
                        {
                            ERROR.InnerHtml = ex.ToString();
                        }
                    }
                    else { ERROR.InnerHtml = "LEVEL"; }
                }
                else { ERROR.InnerHtml = "PASSWORD"; }
            }
            else { ERROR.InnerHtml = "NAME"; }

        }

        protected void btnLogOut_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Server.Transfer("Main.aspx", true);

        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            string id = btn.ID.Split('_')[1];
            string table = btn.ID.Split('_')[0].Split('|')[0];
            //test.Text += id;
            MySqlConnection connetion = new MySqlConnection(myconnection);
            try
            {
                connetion.Open();

                //PRODUCTS
                MySqlCommand command = connetion.CreateCommand();
                command.CommandText = "DELETE FROM " + table + " WHERE id=" + id + "; ";
                MySqlDataReader reader = command.ExecuteReader();
                Response.Redirect(Request.RawUrl);
                connetion.Close();
            }
            catch (Exception ex)
            {
                ERROR.InnerHtml = ex.ToString();
            }

        }
        private void btnEdit_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            string id = btn.ID.Split('_')[1];
            string table = btn.ID.Split('_')[0].Split('|')[0];
            //test.Text += id;

        }


    }
}