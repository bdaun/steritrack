using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IMDBWeb.Secure.deskTopPages
{
    public partial class ShipHeader : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAddShipment_Click(object sender, EventArgs e)
        {
            fvShipHdr.ChangeMode(FormViewMode.Insert);
        }
    }
}