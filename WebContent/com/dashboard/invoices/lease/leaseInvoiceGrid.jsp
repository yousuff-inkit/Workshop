
<%@page import="com.dashboard.invoices.lease.*"%>
<%ClsLeaseInvoiceDAO leasedao=new ClsLeaseInvoiceDAO();%>
  <%String mode=request.getParameter("mode")==null?"":request.getParameter("mode");%>
 <%String desc1 = request.getParameter("desc1")==null?"":request.getParameter("desc1");%> 
 <%String temp=request.getParameter("temp")==null?"0":request.getParameter("temp"); %>
 <%String date1=request.getParameter("date1")==null?"":request.getParameter("date1");%>
 <%String branch=request.getParameter("branch")==null?"":request.getParameter("branch"); %>
 <%String client=request.getParameter("client")==null?"":request.getParameter("client");
 String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
 %>
 
 
 
 <style>
 .greenClass
        {
            background-color: #ACF6CB;
        }
   .greyClass
        {
           background-color: #D8D8D8;
        }
 </style>
<script type="text/javascript">
 var temp4='<%=desc1%>';
var mode1='<%=mode%>';
var invoicedata;
	if(temp4!='')
	{
		if(mode1=="1"){
			
			invoicedata='<%=leasedao.getTotalData(temp,desc1,date1,branch,client,mode,agmtno)%>'; 
	
		}
		else if(mode1=="2"){
			
			invoicedata='<%=leasedao.getLeaseInvoice(temp,desc1,date1,branch,client,mode,agmtno) %>'; 
	
		}

	}
	else
	{
		
		invoicedata;
		
		} 
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'rano' , type: 'int' },
                  		{name : 'voc_no' , type: 'int' },
						{name : 'ratype', type: 'String'  },
						/* {name : 'branch', type: 'int'    }, */
						{name : 'fromdate', type: 'date'  },
						{name : 'todate', type: 'date'  },
						{name : 'acno', type: 'String'  },
						{name : 'acname', type: 'string'  },
						{name : 'amount', type: 'number'  },
						{name : 'cldocno',type:'String'},
						{name :'rentalsum',type:'number'},
						{name :'accsum',type:'number'},
						{name :'salikamt',type:'number'},
						{name :'trafficamt',type:'number'},
						{name  :'saliksrvc',type:'number'},
						{name :'datediff',type:'number'},
						{name :'brhid',type:'String'},
						{name :'curid',type:'String'},
						{name :'insurchg',type:'String'},
						{name :'inv_type',type:'String'},
						{name : 'salikcount',type:'String'},
						{name : 'trafficcount',type:'String'},
						{name : 'salamount',type:'String'},
						{name : 'salrate',type:'String'},
						{name : 'account',type:'number'},
						{name : 'trafficsrvc',type:'number'},
						{name : 'account',type:'number'}
						],
				    localdata: invoicedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
	
	$("#leaseInvoiceGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	
    	});
	
    var cellclassname = function (row, column, value, data) {
        if(typeof(data.amount)=="undefined" || data.amount=="" ){
        	return ""; 
        }
        else{
        	//alert(data.amount);
        	return "greenClass";
        };
          };
 
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#leaseInvoiceGrid").jqxGrid(
    {
        width: '98%',
        height: 510,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: false,
        selectionmode: 'checkbox',
        pagermode: 'default',
        columnsresize: true,
       sortable:false,
				        columns: [
				{ text: 'LA No', datafield: 'rano', width: '4%' ,cellclassname: cellclassname,hidden:true},
				{ text: 'LA No', datafield: 'voc_no', width: '4%' ,cellclassname: cellclassname},
				/* { text: 'RA Type', datafield: 'ratype', width: '6%'}, */
				{ text: 'Start/Last Invoiced', datafield: 'fromdate', width: '7%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname},
				{ text: 'To', datafield: 'todate', width: '7%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname},
				{ text: 'Ac No', datafield: 'acno', width: '5%'   ,cellclassname: cellclassname,hidden:true},
				{ text: 'Ac No', datafield: 'account', width: '5%'   ,cellclassname: cellclassname},
				{ text: 'Ac Name', datafield: 'acname', width: '20%' ,cellclassname: cellclassname},
				{ text: 'Amount', datafield: 'amount', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
				{ text: 'Cldocno', datafield: 'cldocno', width: '12%',cellsformat:'d2',hidden:true,cellclassname: cellclassname},
				{ text: 'Rental Sum', datafield: 'rentalsum', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
				{ text: 'Acc Sum', datafield: 'accsum', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
				{ text: 'salik Amt', datafield: 'salikamt', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
				{ text: 'Traffic Amt', datafield: 'trafficamt', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
				{ text: 'Salik Srvc', datafield: 'saliksrvc', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
				{ text: 'Traffic Srvc', datafield: 'trafficsrvc', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
				{ text: 'DateDifference', datafield: 'datediff', width: '17%',hidden:true,cellclassname: cellclassname},
				{ text: 'Insurance Charges',datafield: 'insurchg', width: '7%',cellsalign:'right',align:'right',cellclassname: cellclassname},
				{ text: 'Brhid', datafield: 'brhid', width: '17%',hidden:true},
				{ text: 'CurId', datafield: 'curid', width: '17%',hidden:true},
				{ text: 'Invtype', datafield: 'inv_type', width: '17%',hidden:true},
				{ text: 'Salik Count', datafield: 'salikcount', width: '17%',hidden:true},
				{ text: 'Traffic Count', datafield: 'trafficcount', width: '17%',hidden:true},
				{ text: 'Sal Amount', datafield: 'salamount', width: '17%',hidden:true},
				{ text: 'Sal Rate', datafield: 'salrate', width: '17%',hidden:true}
						/* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
	
$('#leaseInvoiceGrid').on('rowselect', function (event) 
    		{
    		    // event arguments.
    		    var args = event.args;
    		    // row's bound index.
    		    var rowBoundIndex = event.args.rowindex;
    		    // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
    		    var rowData = event.args.row;
    		    
    		    var todate=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',rowBoundIndex, "todate");
    		  	var docdateval=funDateInPeriodNew(todate);
    		    if(docdateval==0){
    		    	$('#leaseInvoiceGrid').jqxGrid('unselectrow', rowBoundIndex);
    		    }
    		});
    
    var rows=$("#leaseInvoiceGrid").jqxGrid("getrows");
    var rowcount=rows.length;
    if(rowcount==0){
    	$("#leaseInvoiceGrid").jqxGrid("addrow", null, {});	
    }
	  if(document.getElementById("btninvoicesave").style.display=="block"){
 	   $('#leaseInvoiceGrid').jqxGrid({ height: 535 });
    }
   
});

	
	
</script>
<div id="leaseInvoiceGrid"></div>