<%@page import="com.dashboard.invoices.extraservices.ClsExtraServiceInvDAO" %>
<%ClsExtraServiceInvDAO csi=new ClsExtraServiceInvDAO(); %>

 <%String uptodate=request.getParameter("uptodate")==null?"":request.getParameter("uptodate");%>
 <%String branchvalue=request.getParameter("branch")==null?"0":request.getParameter("branch"); %>
<%String temp=request.getParameter("temp")==null?"0":request.getParameter("temp"); %>
<!--  <style>
 .greenClass
        {
            background-color: #ACF6CB;
        }
   .greyClass
        {
           background-color: #D8D8D8;
        }
 </style> -->




<script type="text/javascript">
var exservicedata;
var temp1='<%=temp%>';
if(temp1=="1"){
	exservicedata='<%= csi.getExServiceInvData(uptodate,branchvalue,temp)%>';
}
else{
	exservicedata;
}

	$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
						{name : 'doc_no',type: 'int'},
                  		{name : 'rano' , type: 'int' },
                  		{name : 'refvocno',type:'int'},
						{name : 'ratype', type: 'String'  },
						/* {name : 'branch', type: 'int'    }, */
						{name : 'date', type: 'date'  },
						
						{name : 'acno', type: 'String'  },
						{name : 'acname', type: 'string'  },
						{name : 'amount', type: 'number'  },
						{name : 'cldocno',type:'String'},
						
						
						],
				    localdata: exservicedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
  /*   var cellclassname = function (row, column, value, data) {
        if(typeof(data.amount)=="undefined" || data.amount=="" ){
        	return "greyClass"; 
        }
        else{
        	//alert(data.amount);
        	return "greenClass";
        };
          }; */
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#extraServiceInvGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
        pagermode: 'default',
       sortable:false,
        columns: [
               
						{ text: 'Doc No', datafield: 'doc_no', width: '10.5%' },
						{ text: 'Original RA No', datafield: 'rano', width: '10.5%',hidden:true  },
						{ text: 'RA No', datafield: 'refvocno', width: '10.5%'},
						{ text: 'RA Type', datafield: 'ratype', width: '10.5%' },
						{ text: 'Date', datafield: 'date', width: '10.5%',cellsformat:'dd.MM.yyyy' },
						
						{ text: 'Ac No', datafield: 'acno', width: '10.5%' },
						{ text: 'Ac Name', datafield: 'acname', width: '34%'},
						{ text: 'Amount', datafield: 'amount', width: '10.5%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{ text: 'Cldocno', datafield: 'cldocno', width: '12%',cellsformat:'d2',hidden:true},
						
						
					]

    });

    
/*     var rows=$("#rentalInvoiceGrid").jqxGrid("getrows");
    var rowcount=rows.length;
    if(rowcount==0){
    	$("#rentalInvoiceGrid").jqxGrid("addrow", null, {});	
    }
    */
});

	
	
</script>
<div id="extraServiceInvGrid"></div>