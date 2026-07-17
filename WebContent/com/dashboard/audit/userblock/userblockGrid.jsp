<%@page import="com.dashboard.audit.userblock.ClsuserblockDAO"%>
<%
ClsuserblockDAO listdao=new ClsuserblockDAO();


String branchval = request.getParameter("branch")==null?"":request.getParameter("branch");
String doc_no = request.getParameter("doc_no")==null?"":request.getParameter("doc_no");
String check = request.getParameter("check")==null?"":request.getParameter("check");
%>
<script type="text/javascript">
var detaildata;
var temp='<%=branchval%>';

	if(temp!='NA'){ 
	 detaildata='<%=listdao.getuserDataGrid(doc_no,branchval,check)%>';
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'doc_no', type: 'String'  },
					{name : 'user_name', type: 'String'  },
					{name : 'date', type: 'date'  },
					
					{name : 'email', type: 'String' },
					{name : 'userinfo', type: 'String' }
					
						],
				    localdata: detaildata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    $("#userblockGrid").on("bindingcomplete", function (event) {$('#overlay,#PleaseWait').hide();});  
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#userblockGrid").jqxGrid(
    {
    	width: '99%',
        height: 580,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        columnsresize:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
					{ text: 'Sr. No.',datafield: '',columntype:'number', width: '8%', cellsrenderer: function (row, column, value) {
					    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					}   },	
					{text: 'Doc No',datafield:'doc_no',width:'15%'},
					{text: 'Username',datafield:'user_name',width:'27%'},
					{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy', width: '25%' },
					{ text: 'Email', datafield: 'email', width: '25%' },
					{ text: 'User Info', datafield: 'userinfo', hidden: true, width: '20%' }
					
					]
    
    });
    
    $('#userblockGrid').on('rowdoubleclick', function (event)  { 
    	var rowindex1 = event.args.rowindex;
    	document.getElementById("bdocno").value= $('#userblockGrid').jqxGrid('getcellvalue',rowindex1, "doc_no");
    	$('#btnblock').attr("disabled",false);
    	var values= $('#userblockGrid').jqxGrid('getcellvalue',rowindex1, "userinfo");
          
    	var sum2 = values.toString().replace(/\*/g,'\n');
       
    	document.getElementById("txtclientname").value=sum2;
    			
    		});
});

</script>
<div id="userblockGrid"></div>