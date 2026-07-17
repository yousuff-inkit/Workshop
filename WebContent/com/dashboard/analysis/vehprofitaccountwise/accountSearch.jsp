<%@page import="com.dashboard.analysis.vehprofitaccountwise.*" %>
<% ClsVehProfitAccountWiseDAO profitdao=new ClsVehProfitAccountWiseDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String accounttype=request.getParameter("accounttype")==null?"0":request.getParameter("accounttype");
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=id%>';
   var accountdata=[];
   if(id=='1'){
	   accountdata='<%=profitdao.getAccount(id,accounttype)%>';
	
}
else{
	accountdata=[];
}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'account',type:'number'},
                  		{name : 'doc_no',type:'number'},
                  		{name : 'description',type:'String'},
                  		
                  		
                  		],
				    localdata: accountdata,
        
        
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
    
    
    $("#accountSearch").jqxGrid(
    {
        width: '100%',
        height: 330,
        source: dataAdapter,
        showaggregates:true,
        //filtermode:'excel',
        showfilterrow:true,
        filterable: true,
        selectionmode: 'checkbox',
       sortable:false,
        columns: [
               
					{ text:'Doc No', filtertype:'number',datafield:'doc_no',width:'20%',hidden:true},
       				{ text:'Account No', filtertype:'number',datafield:'account',width:'20%'},
       				{ text:'Name',filtertype:'input',columntype:'textbox',datafield:'description',width:'75%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    $('#accountSearch').on('rowselect', function (event) 
    		{
    		    // event arguments.
    		    var args = event.args;
    		    // row's bound index.
    		    var rowBoundIndex = event.args.rowindex;
    		    // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
    		    var rowData = event.args.row;
    		    var selectedrowindexes = $('#accountSearch').jqxGrid('selectedrowindexes'); 
    		    var accounttype='<%=accounttype%>';
    		    var message="";
    		    if(accounttype=="income"){
    		    	message=" of Income A/c";
    		    }
    		    else{
    		    	message=" of Expense A/c";
    		    }
    		    if(selectedrowindexes.length>5){
    		    	$.messager.alert('Warning','Cannot Add More than 5 accounts'+message);
    		    	return false;
    		    }
    		});
    $( "#btnaccountok" ).click(function() {
    	var rows = $("#accountSearch").jqxGrid('selectedrowindexes');
	    var accounttype='<%=accounttype%>';
	    var message="";
	    var accountheading="";
	    if(accounttype=="income"){
	    	message=" of Income A/c";
	    	accountheading=" Income";
	    }
	    else{
	    	message=" of Expense A/c";
	    	accountheading=" Expense";
	    }
	    if(rows.length>5){
	    	$.messager.alert('Warning','Cannot Add More than 5 accounts'+message);
	    	return false;
	    }
	    
	    
    	if(rows!=""){
    		if(accounttype=="income"){
    			if(document.getElementById("searchdetails").value==""){
            		document.getElementById("searchdetails").value="Account"+accountheading;
            		document.getElementById("incomeaccount").value="Account"+accountheading;
            	}
            	else{
            		document.getElementById("searchdetails").value+="\n\nAccount"+accountheading;
            		document.getElementById("incomeaccount").value+="\nAccount"+accountheading;
            	}		
    		}
    		else{
    			if(document.getElementById("searchdetails").value==""){
            		document.getElementById("searchdetails").value="Account"+accountheading;
            		document.getElementById("expenseaccount").value="Account"+accountheading;
            	}
            	else{
            		document.getElementById("searchdetails").value+="\n\nAccount"+accountheading;
            		document.getElementById("expenseaccount").value+="\nAccount"+accountheading;
            	}
    		}
    		
    	}
    	
    	if(accounttype=="income"){
    		for(var i=0;i<rows.length;i++){
        		var dummy=$('#accountSearch').jqxGrid('getcellvalue',rows[i],'description');
        		var docno=$('#accountSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
        		document.getElementById("searchdetails").value+="\n"+dummy;
        		document.getElementById("incomeaccount").value+="\n"+dummy;
        		if(i==0){
        			if(document.getElementById("hidincomeaccount").value!=""){
        				document.getElementById("hidincomeaccount").value+=","+docno;	
        			}
        			else{
        				document.getElementById("hidincomeaccount").value=docno;
        			}
        			
        		}
        		else{
        			document.getElementById("hidincomeaccount").value+=","+docno;
        		}
        	}	
    	}
    	else{
    		for(var i=0;i<rows.length;i++){
        		var dummy=$('#accountSearch').jqxGrid('getcellvalue',rows[i],'description');
        		var docno=$('#accountSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
        		document.getElementById("searchdetails").value+="\n"+dummy;
        		document.getElementById("expenseaccount").value+="\n"+dummy;
        		if(i==0){
        			if(document.getElementById("hidexpenseaccount").value!=""){
        				document.getElementById("hidexpenseaccount").value+=","+docno;	
        			}
        			else{
        				document.getElementById("hidexpenseaccount").value=docno;
        			}
        			
        		}
        		else{
        			document.getElementById("hidexpenseaccount").value+=","+docno;
        		}
        	}	
    	}
    	
    	
    	$('#accountwindow').jqxWindow('close');
    	});
    
    $( "#btnaccountclear" ).click(function() {
    	$('#accountwindow').jqxWindow('close');
    	});
});

</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnaccountok" name="btnaccountok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btnaccountclear" name="btnaccountclear" class="myButton" >Cancel</button></div>
<div id="accountSearch"></div>
