<%@page import="com.dashboard.client.clientvehiclemovement.*"%>
<%
ClsClientVehicleMovementDAO movdao=new ClsClientVehicleMovementDAO();
String client = request.getParameter("client")==null?"":request.getParameter("client");
String mobile = request.getParameter("mobile")==null?"":request.getParameter("mobile");
String license = request.getParameter("license")==null?"":request.getParameter("license");
String passport = request.getParameter("passport")==null?"":request.getParameter("passport");
String nation = request.getParameter("nation")==null?"":request.getParameter("nation");
String dob = request.getParameter("dob")==null?"":request.getParameter("dob");
String id = request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var clientdata;
var id='<%=id%>';
if(id=="1"){
	 clientdata='<%=movdao.getClient(client,mobile,license,passport,nation,dob,id)%>';
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'cldocno', type: 'String'  },
					{name : 'refname', type: 'String'  },
					{name : 'per_mob', type: 'String'  },
					{name : 'dob', type: 'date' },
					{name : 'license', type: 'String'  }, 
					{name : 'nation', type: 'String' },
					{name : 'passport',type:'string'}
					
						
						],
				    localdata: clientdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#clientSearchGrid").jqxGrid(
    {
    	width: '99%',
        height: 250,
        source: dataAdapter,
       // rowsheight:20,
       // showaggregates:true,
       filtermode:'excel',
       // filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Client No', datafield: 'cldocno', width: '10%' },
					{ text: 'Name', datafield: 'refname', width: '30%' },
					{ text: 'DoB', datafield: 'dob', width: '10%', cellsformat: 'dd.MM.yyyy' },
					{ text: 'Mobile', datafield: 'per_mob', width: '15%' },
					{ text: 'License', datafield: 'license', width: '10%' },
					{ text: 'Nation', datafield: 'nation', width: '15%' },
					{ text: 'Passport', datafield: 'passport', width: '10%' }
						
					
					]
    
    });
    $('#clientSearchGrid').on('rowdoubleclick', function (event) 
    		{ 
    	var rowindex1=event.args.rowindex;
		$('#client').val($('#clientSearchGrid').jqxGrid('getcellvalue',rowindex1,'refname'));
		$('#hidclient').val($('#clientSearchGrid').jqxGrid('getcellvalue',rowindex1,'cldocno'));
        $('#clientwindow').jqxWindow('close');
    		});
});

</script>
<div id="clientSearchGrid"></div>