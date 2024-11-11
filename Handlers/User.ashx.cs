using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;

namespace ticit.Handlers
{
    /// <summary>
    /// Summary description for User
    /// </summary>
    public class User : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            string action = context.Request["action"];
            string responseMessage = string.Empty;

            // Check the action to determine what to do
            if (action == "UpsertUser")
            {
                responseMessage = UpsertUser(context);
            }
            else if (action == "RemoveUser")
            {
                int userID = int.Parse(context.Request["UserID"]);
                responseMessage = RemoveUserAndRelatedData(userID);
            }
            else
            {
                // Handle other actions if needed
                responseMessage = "Action not recognized.";
            }

            // Send response back to the client
            context.Response.ContentType = "text/plain";
            context.Response.Write(responseMessage);
        }

        // Function to insert or update user data
        private string UpsertUser(HttpContext context)
        {
            string responseMessage = string.Empty;
            string connectionString = ConfigurationManager.ConnectionStrings["TicitDbConnection"].ConnectionString;

            // Example parameters from the request
            string username = context.Request["Username"];
            string passwordHash = context.Request["PasswordHash"];
            string email = context.Request["Email"];
            string phone = context.Request["Phone"];
            string userType = context.Request["UserType"];
            decimal walletBalance = decimal.TryParse(context.Request["WalletBalance"], out var balance) ? balance : 50.00m;
            int discountPercentage = int.TryParse(context.Request["DiscountPercentage"], out var discount) ? discount : 5;
            int? userId = int.TryParse(context.Request["UserID"], out var id) ? (int?)id : null;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("UpsertUser", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Input parameters
                    if (userId.HasValue)
                        cmd.Parameters.AddWithValue("@UserID", userId.Value);
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@PasswordHash", passwordHash);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Phone", phone);
                    cmd.Parameters.AddWithValue("@UserType", userType);
                    cmd.Parameters.AddWithValue("@WalletBalance", walletBalance);
                    cmd.Parameters.AddWithValue("@DiscountPercentage", discountPercentage);

                    // Output parameter
                    SqlParameter responseParam = new SqlParameter("@ResponseMessage", SqlDbType.NVarChar, 4000)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(responseParam);

                    try
                    {
                        // Open connection and execute
                        conn.Open();
                        cmd.ExecuteNonQuery();

                        // Get the response from the output parameter
                        responseMessage = responseParam.Value.ToString();
                    }
                    catch (Exception ex)
                    {
                        // Handle error
                        responseMessage = "Error: " + ex.Message;
                    }
                }
            }

            return responseMessage;
        }

        // Function to remove the user and related data
        private string RemoveUserAndRelatedData(int userID)
        {
            string responseMessage = string.Empty;
            string connectionString = ConfigurationManager.ConnectionStrings["TicitDbConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("RemoveUserAndRelatedData", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Input parameter
                    cmd.Parameters.AddWithValue("@UserID", userID);

                    // Output parameter
                    SqlParameter responseParam = new SqlParameter("@ResponseMessage", SqlDbType.NVarChar, 4000)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(responseParam);

                    try
                    {
                        // Open connection and execute
                        conn.Open();
                        cmd.ExecuteNonQuery();

                        // Get the response from the output parameter
                        responseMessage = responseParam.Value.ToString();
                    }
                    catch (Exception ex)
                    {
                        // Handle error
                        responseMessage = "Error: " + ex.Message;
                    }
                }
            }

            return responseMessage;
        }

        public bool IsReusable
        {
            get { return false; }
        }
    }
}
