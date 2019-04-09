Binding dropdown based on previous dropdown data without pageload by using jquery.

---.CS binding code----
 public void bindddlcompay()
    {

        //DataTable dtState = CompanyRegistrationDAL.GetCompaneyname(objcr);
        DataTable dtState = ClientDAL.Get_Client_name(objcr);
        //ddlcompanyname.DataSource = dtState;
        //ddlcompanyname.DataTextField = "CLIENT_NAME";
        ddlcompanyname.DataValueField = "CLIENT_REG_ID";
        //ddlcompanyname.DataBind();
        //ddlcompanyname.Items.Insert(0, new ListItem("--Select Company--"));
        string[] Noticeperiod = { "-- Select NoticePeriod --", "Immediate", "0 to 15 days", "1 Month", "2 Months", "3 Months", "4 Months", "5 Months", "6 Months" };
        ddlnotice.DataSource = Noticeperiod;
        ddlnotice.DataBind();



    }
    
     [WebMethod]
    public static string[] GetSpoc(int name)
    {
        SpocEntity obj = new SpocEntity();
        obj.CmpnyID = name;
        ClientDAL objDAL = new ClientDAL();
        objDAL.GetSpocListbyClientId(obj);
        string[] statesArr = obj.SPOC_NAME.Split(',');
        string[] returnstr = new string[statesArr.Length];
        for (int i = 0; i < statesArr.Length; i++)
        {
            if (statesArr[i] != "" || statesArr[i] != null)
                returnstr[i] = statesArr[i];
        }
        return returnstr;
    }
    
    <--javaScript-->
      <script>
         var  ele_spoc;
        var parm_cmpy;

function getSpocFun() {
            $.ajax({
                type: "POST",
                url: "bdm-requirementadd.aspx/GetSpoc",
                data: '{name: ' + JSON.stringify(parm_cmpy) + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (resp) {
                    ele_spoc.empty().append("<option>-- SELECT --</option>");
                    $(resp.d).each(function (index, res) {
                        if(res != '')
                        ele_spoc.append("<option value='" + res + "'>" + res + "</option>");
                    });
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }


 $("#cphBody_ddlcompanyname").change(function () {
            parm_cmpy = $(this).val();
            ele_spoc = $("#cphBody_ddlspocname");
           // $("#cphBody_ddlcompanyname").empty().append("<option value='-- SELECT --'>-- SELECT --</option>");
            getSpocFun();
        });

	
    </script>
