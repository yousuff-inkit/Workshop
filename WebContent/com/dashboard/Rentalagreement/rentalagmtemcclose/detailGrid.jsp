 <%@page import="com.dashboard.rentalagreement.rentalagmtemcclose.*"%>
 <%ClsRentalAgmtEMCCloseDAO closedao=new ClsRentalAgmtEMCCloseDAO();
 String id=request.getParameter("id")==null?"":request.getParameter("id");
 String date=request.getParameter("date")==null?"":request.getParameter("date");
 String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
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
 .redClass
   		{
   		   background:#FFEBEB;
   		}
 </style>

<script type="text/javascript">
var data;
var id='<%=id%>';
if(id=="1"){
	data='<%=closedao.getAgmtData(branch,date,id)%>';
}
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

/* agmt.doc_no,agmt.voc_no,ac.refname,veh.reg_no,veh.fleet_no,agmt.odate outdate,agmt.otime outtime,agmt.emcjobcard,agmt.emccourtesydays,"+
" agmt.emcrate,agmt.ddate duedate,agmt.dtime duetime */
                  		{name : 'doc_no' , type: 'number' },
						{name : 'voc_no', type: 'String'  },
						{name : 'refname', type: 'string'    },
						{name : 'reg_no', type: 'number'  },
						{name : 'fleet_no', type: 'number'  },
						{name : 'flname',type:'string'},
						{name : 'outdate', type: 'date'  },
						{name : 'outtime', type: 'string'  },
						{name : 'outkm', type: 'number'  },
						{name : 'outfuel',type:'String'},
						{name :'outfuelvalue',type:'string'},
						{name :'emcjobcard',type:'string'},
						{name :'emcrate',type:'string'},
						{name :'duedate',type:'date'},
						{name  :'duetime',type:'string'},
						{name : 'emccourtesydays', type: 'number'  },
						{name : 'totalkm',type:'number'}
						],
				    localdata: data,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    $("#detailGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
//    	$('#rentalInvoiceGrid').jqxGrid({ sortable: true});
    	});
    
    var cellclassname = function (row, column, value, data) {
     /* if(typeof(data.amount)=="undefined" || data.amount=="" ){
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
        	
        }; */
       
          };
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#detailGrid").jqxGrid(
    {
        width: '98%',
        height: 510,
        source: dataAdapter,
        showaggregates:true,
        columnsresize:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       sortable:false,
        columns: [
               
						{ text: 'RA No', datafield: 'doc_no', width: '10%'  ,cellclassname: cellclassname,hidden:true},
						{ text: 'RA No', datafield: 'voc_no', width: '8%'  ,cellclassname: cellclassname},
						{ text: 'Client', datafield: 'refname', width: '20%' ,cellclassname: cellclassname},
						{ text: 'Reg No', datafield: 'reg_no', width: '7%',cellclassname: cellclassname },
						{ text: 'Fleet No', datafield: 'fleet_no', width: '7%' ,cellclassname: cellclassname},
						{ text: 'Fleet Name',datafield:'flname',width:'17%' ,cellclassname: cellclassname},
						{ text: 'Out Date', datafield: 'outdate', width: '6%'   ,cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
						{ text: 'Out Time', datafield: 'outtime', width: '6%'   ,cellsformat:'HH:mm',cellclassname: cellclassname},
						{ text: 'Out Km', datafield: 'outkm', width: '6%',cellclassname: cellclassname,cellsformat:'d',hidden:false},
						{ text: 'Out Fuel', datafield: 'outfuelvalue', width: '6%',cellclassname: cellclassname,cellsformat:'d3',hidden:true},
						{ text: 'Out Fuel', datafield: 'outfuel', width: '6%',cellclassname: cellclassname,hidden:true},
						{ text: 'Job Card No', datafield: 'emcjobcard', width: '9%'},
						{ text: 'Courtesy Days', datafield: 'emccourtesydays', width: '8%',cellsformat:'d' ,cellclassname: cellclassname},
						{ text: 'Due Date', datafield: 'duedate', width: '6%'   ,cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
						{ text: 'Due Time', datafield: 'duetime', width: '6%'   ,cellsformat:'HH:mm',cellclassname: cellclassname},
						{ text: 'Total Km', datafield: 'totalkm', width: '6%'   ,cellsformat:'d2',cellclassname: cellclassname},
					]

    });
$('#detailGrid').on('rowdoubleclick', function (event) 
    		{
    		    // event arguments.
    		    var args = event.args;
    		    // row's bound index.
    		    var rowBoundIndex = event.args.rowindex;
    		    // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
    		    var rowData = event.args.row;
    		    $('#client').val($('#detailGrid').jqxGrid('getcellvalue',rowBoundIndex,'refname'));
    		    $('#rowindex').val(rowBoundIndex);
    		    $('#agmtno').val($('#detailGrid').jqxGrid('getcellvalue',rowBoundIndex,'doc_no'));
    		    $('#inkm').val($('#detailGrid').jqxGrid('getcellvalue',rowBoundIndex,'totalkm'));
    		    /* 
    		    
    		    var todate=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',rowBoundIndex, "todate");
    		  	var docdateval=funDateInPeriodNew(todate);
    		    if(docdateval==0){
    		    	$('#rentalInvoiceGrid').jqxGrid('unselectrow', rowBoundIndex);
    		    }
    		    var duedatecal=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',rowBoundIndex, "duedatecal");
    		    if(duedatecal==1){
    		    	$('#rentalInvoiceGrid').jqxGrid('unselectrow', rowBoundIndex);
    		    	$.messager.alert('Warning',"Due Date Exceeded.");
    		    } */
    		});
     
 /*    var rows=$("#rentalInvoiceGrid").jqxGrid("getrows");
    var rowcount=rows.length;
    if(rowcount==0){
    	$("#rentalInvoiceGrid").jqxGrid("addrow", null, {});	
    }
   if(document.getElementById("btninvoicesave").style.display=="block"){
	   $('#rentalInvoiceGrid').jqxGrid({ height: 535 });
   } */
});

	
</script>
<div id="detailGrid"></div>
<input type="hidden" id="rowindex" name="rowindex">