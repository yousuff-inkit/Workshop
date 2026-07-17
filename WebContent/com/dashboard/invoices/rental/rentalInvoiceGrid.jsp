 <%@page import="com.dashboard.invoices.rental.*"%>
 <%ClsRentalInvoiceDAO rentaldao=new ClsRentalInvoiceDAO();%>
 <%String desc1 = request.getParameter("desc1")==null?"":request.getParameter("desc1");%> 
 <%String temp=request.getParameter("temp")==null?"0":request.getParameter("temp"); %>
 <%String date1=request.getParameter("date1")==null?"":request.getParameter("date1");%>
 <%String branch=request.getParameter("branch")==null?"":request.getParameter("branch"); %>
 <%String client=request.getParameter("client")==null?"":request.getParameter("client"); %>
 <%String mode=request.getParameter("mode")==null?"":request.getParameter("mode");%>
 <style>
 .greenClass
        {
            background-color: #ACF6CB;
        }
 .greyClass
        {
           background-color: #D8D8D8;
        }
 .redClass
   		{
   		   background:#FFEBEB;
   		}
 </style>

<script type="text/javascript">
 var temp4='<%=desc1%>';
var invoicedata;
var mode1='<%=mode%>';
if(temp4!='NA' && temp4!='a')
{ 
	if(mode1=="1"){
		invoicedata='<%=rentaldao.getTotaldata(temp,desc1,date1,branch,client,mode)%>';  
	}
	else if(mode1=="2"){
		invoicedata='<%=rentaldao.getRentalInvoice(temp,desc1,date1,branch,client,mode)%>';	 
	}
	else{
		
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
						{name : 'ratype', type: 'String'  },
						{name : 'voc_no', type: 'int'    },
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
						{name :'invtype',type:'String'},
						{name : 'salikcount',type:'String'},
						{name : 'trafficcount',type:'String'},
						{name :'salamount',type:'string'},
						{name :'salrate',type:'string'},
						{name : 'account',type:'number'},
						{name : 'duedatecal',type:'number'},
						{name : 'trafficsrvc',type:'number'}
						],
				    localdata: invoicedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    $("#rentalInvoiceGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
//    	$('#rentalInvoiceGrid').jqxGrid({ sortable: true});
    	});
    
    var cellclassname = function (row, column, value, data) {
     if(typeof(data.amount)=="undefined" || data.amount=="" ){
        	if(data.duedatecal==1){
            	return "redClass";
            }
        	else{
        		return "greyClass";	
        	};
        	 
        }
        else{
        	//alert(data.amount);
        	if(data.duedatecal==1){
            	return "redClass";
            }
        	else{
        		return "greenClass";	
        	};
        	
        };
       
          };
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#rentalInvoiceGrid").jqxGrid(
    {
        width: '98%',
        height: 510,
        source: dataAdapter,
        showaggregates:true,
        columnsresize:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
        pagermode: 'default',
       sortable:false,
        columns: [
               
						{ text: 'RA No', datafield: 'rano', width: '4%'  ,cellclassname: cellclassname,hidden:true},
						{ text: 'RA No', datafield: 'voc_no', width: '4%'  ,cellclassname: cellclassname},
						{ text: 'RA Type', datafield: 'ratype', width: '6%' ,cellclassname: cellclassname},
						{ text: 'Start/Last Invoiced', datafield: 'fromdate', width: '6%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
						{ text: 'To', datafield: 'todate', width: '6%',cellsformat:'dd.MM.yyyy'  ,cellclassname: cellclassname},
						{ text: 'Ac No', datafield: 'acno', width: '5%'   ,cellclassname: cellclassname,hidden:true},
						{ text: 'Ac No', datafield: 'account', width: '5%'   ,cellclassname: cellclassname},
						{ text: 'Ac Name', datafield: 'acname', width: '20%'  ,cellclassname: cellclassname},
						{ text: 'Amount', datafield: 'amount', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname},
						{ text: 'Cldocno', datafield: 'cldocno', width: '12%',cellsformat:'d2',hidden:true},
						{ text: 'Rental Sum', datafield: 'rentalsum', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname},
						{ text: 'Acc Sum', datafield: 'accsum', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname},
						{ text: 'salik Amt', datafield: 'salikamt', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname},
						{ text: 'Traffic Amt', datafield: 'trafficamt', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname},
						{ text: 'Salik Srvc', datafield: 'saliksrvc', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname},
						{ text: 'Traffic Srvc', datafield: 'trafficsrvc', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname},
						{ text: 'DateDifference', datafield: 'datediff', width: '17%',hidden:true},
						{ text: 'Insurance Charges',datafield: 'insurchg', width: '7%',cellsalign:'right',align:'right' ,cellclassname: cellclassname},
						{ text: 'Brhid', datafield: 'brhid', width: '17%',hidden:true},
						{ text: 'CurId', datafield: 'curid', width: '17%',hidden:true},
						{ text: 'Invtype', datafield: 'invtype', width: '17%',hidden:true},
						{ text: 'Salik Count', datafield: 'salikcount', width: '17%',hidden:true},
						{ text: 'Traffic Count', datafield: 'trafficcount', width: '17%',hidden:true},
						{ text: 'Salik Amount', datafield: 'salamount', width: '17%',hidden:true},
						{ text: 'Salik Rate', datafield: 'salrate', width: '17%',hidden:true},
						{ text: 'duedatecal', datafield: 'duedatecal', width: '17%',hidden:true,cellclassname: cellclassname}
						/* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
$('#rentalInvoiceGrid').on('rowselect', function (event) 
    		{
    		    // event arguments.
    		    var args = event.args;
    		    // row's bound index.
    		    var rowBoundIndex = event.args.rowindex;
    		    // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
    		    var rowData = event.args.row;
    		    
    		    
    		    var todate=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',rowBoundIndex, "todate");
    		  	var docdateval=funDateInPeriodNew(todate);
    		    if(docdateval==0){
    		    	$('#rentalInvoiceGrid').jqxGrid('unselectrow', rowBoundIndex);
    		    }
    		    var duedatecal=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',rowBoundIndex, "duedatecal");
    		    if(duedatecal==1){
    		    	$('#rentalInvoiceGrid').jqxGrid('unselectrow', rowBoundIndex);
    		    	$.messager.alert('Warning',"Due Date Exceeded.");
    		    }
    		});
    
    var rows=$("#rentalInvoiceGrid").jqxGrid("getrows");
    var rowcount=rows.length;
    if(rowcount==0){
    	$("#rentalInvoiceGrid").jqxGrid("addrow", null, {});	
    }
   if(document.getElementById("btninvoicesave").style.display=="block"){
	   $('#rentalInvoiceGrid').jqxGrid({ height: 535 });
   }
});

	
	
</script>
<div id="rentalInvoiceGrid"></div>