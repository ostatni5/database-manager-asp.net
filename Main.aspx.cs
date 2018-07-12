using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data;
using MySql.Data.MySqlClient;
using System.Data.SqlClient;

namespace MagazynBaza
{
    public partial class Main : System.Web.UI.Page
    {

        MySqlConnection connect()
        {
            string myconnection = "SERVER=localhost;DATABASE=magazyn;UID=root;";

            MySqlConnection connection = new MySqlConnection(myconnection);

            try
            {

                connection.Open();
                Console.WriteLine("Connected");
                return connection;

            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.WriteLine("Error",ex.ToString());
            }
            return null;
        }




        protected void Page_Load(object sender, EventArgs e)
        {

            string user_name = (string)(Session["user_name"]);
            if (user_name == "error" || user_name == null)
            {
                //Server.Transfer("Main.aspx", true);
            }
            else
            {
                try
                {
                    Server.Transfer("Panel.aspx", true);
                }
                catch (Exception ex)
                { }
            }

        }

        int user_id=0;
        string user_level="99",user_name = "error";

        MySqlConnection log_con;
        protected void btnLogIn_Click(object sender, EventArgs e)
        {
            string myconnection = "SERVER=localhost;DATABASE=magazyn;UID=root;";
            log_con = new MySqlConnection(myconnection);
            try
            {

                log_con.Open();
                lbInfo1.Visible = true;
                lbInfo1.Text = "Połączono z bazą";
                MySqlCommand command = log_con.CreateCommand();


                command.Parameters.AddWithValue("@Login", tbLogin.Text);
                command.Parameters.AddWithValue("@Pass", tbPass.Text);

                command.CommandText = "SELECT * FROM users WHERE login=@Login AND pass=SHA1(@Pass)";
                MySqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {

                    user_id = (int)reader["id"];
                    user_name = (string)reader["login"];
                    user_level = reader["level"].ToString();

                }
                if (user_id > 0)
                {
                    lbInfoLogin.Text = "Zalogowano pomyślnie: "+user_name +"| poziom :"+user_level;
                    Session["user_name"] = user_name;
                    Session["user_level"] = user_level;
                    try {
                        Server.Transfer("Panel.aspx", true);
                    }
                    catch (Exception ex) {
                    }
                }
                else
                {
                    lbInfoLogin.Text = "Błedny login lub hasło";
                }

            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                lbInfo1.Visible = true;
                lbInfo1.Text = ex.ToString();
            }
            
        } 
        
        
    }
}