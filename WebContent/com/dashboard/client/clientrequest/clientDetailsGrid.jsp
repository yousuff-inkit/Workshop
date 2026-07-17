<%@ page import="com.dashboard.client.ClsClientDAO" %>
<% ClsClientDAO cld=new ClsClientDAO();
String check = request.getParameter("check")==null?"":request.getParameter("check");%>

<script type="text/javascript">
        
     var data= '<%=cld.clientDetailsSearch(check)%>';  
     $(document).ready(function () { 
     	
        // prepare the data
        var source =
        {
            datatype: "json",
            datafields: [
						{name : 'cldocno', type: 'int'   },
 						{name : 'account', type: 'string'   },
 						{name : 'description', type: 'string'  }
                    ],
            		    localdata: data, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#jqxClientSearch").jqxGrid(
        {
            width: '100%',
            height: 350,
            source: dataAdapter,
            showfilterrow: true, 
            filterable: true, 
            selectionmode: 'singlerow',
            
            columns: [
						{ text: 'Doc No',  datafield: 'cldocno', hidden: true, width: '5%' },
						{ text: 'Client Id', datafield: 'account', width: '40%' },
						{ text: 'Client Name', datafield: 'description', width: '60%' },
					]
        });
        
         $('#jqxClientSearch').on('rowdoubleclick', function (event) {
            var rowindex1 = event.args.rowindex;
            document.getElementById("txtcldocno").value = $('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
        	document.getElementById("txtclientname").value = $('#jqxClientSearch').jqxGrid('getcellvalue', rowindex1, "description");
	       	
        	$('#clientDetailsWindow').jqxWindow('close'); 
        });  
    });
</script>
<div id="jqxClientSearch"></div>
