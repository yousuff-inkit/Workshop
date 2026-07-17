<%@page import="com.dashboard.invoices.extrakm.ClsExtraKmDAO" %>
<% ClsExtraKmDAO ckd=new ClsExtraKmDAO(); %>
 <%String temp=request.getParameter("temp")==null?"0":request.getParameter("temp"); %>
 <%String date1=request.getParameter("date1")==null?"":request.getParameter("date1");%>
 <%String branch=request.getParameter("branch")==null?"":request.getParameter("branch"); %>
 <%String client=request.getParameter("client")==null?"":request.getParameter("client"); %>
<%-- <%System.out.println("branch="+branch+"&date1="+date1+"&client="+client+"&temp="+temp);%> --%>
 <style>
 .greenClass
        {
           /*  background-color: #ACF6CB; */
        }
   .greyClass
        {
           /* background-color: #D8D8D8; */
        }
 </style>




<script type="text/javascript">
var exkmdata;
var temp='<%=temp%>';
if(temp=="1"){
	exkmdata='<%=ckd.getInvoice(temp,date1,branch,client)%>';
}
else{
	exkmdata;
}
	

	$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'agmtno' , type: 'int' },
						{name : 'agmttype', type: 'String'  },
						{name : 'voc_no', type: 'int'    },
						{name : 'fromdate', type: 'date'  },
						{name : 'todate', type: 'date'  },
						{name : 'acno', type: 'String'  },
						{name : 'acname', type: 'string'  },
						{name : 'excesskmamt',type:'number'},
						{name : 'excessfuelamt',type:'number'},
						{name : 'cldocno',type:'String'},
						{name :'totalkm',type:'number'},
						{name :'excesskm',type:'number'},
						{name :'excessfuel',type:'number'},
						{name : 'kmrest',type:'number'},
						{name : 'exkmrte',type:'number'},
						{name : 'fuelrate',type:'number'},
						{name : 'branchid',type:'number'},
						{name : 'currencyid',type:'number'},
						
						
						],
				    localdata: exkmdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    $("#extraKmGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});
    var cellclassname = function (row, column, value, data) {
        if(typeof(data.amount)=="undefined" || data.amount=="" ){
        	return "greyClass"; 
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
    
    
    $("#extraKmGrid").jqxGrid(
    {
        width: '100%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
        pagermode: 'default',
       sortable:false,
        columns: [
               
						{ text: 'Sr. No.',datafield: '',columntype:'number',cellclassname: cellclassname, width: '5%', 
								cellsrenderer: function (row, column, value) {
							    	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
								}
						},
						
						{ text: 'Agmt No', datafield: 'voc_no', width: '5%'  ,cellclassname: cellclassname},
						{ text: 'Agmt Type', datafield: 'agmttype', width: '7%' ,cellclassname: cellclassname},
						{ text: 'Start Date', datafield: 'fromdate', width: '8%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
						{ text: 'To Date', datafield: 'todate', width: '8%',cellsformat:'dd.MM.yyyy'  ,cellclassname: cellclassname},
						{ text: 'Ac No', datafield: 'acno', width: '8%'   ,cellclassname: cellclassname},
						{ text: 'Ac Name', datafield: 'acname', width: '20%'  ,cellclassname: cellclassname},
						{ text: 'Used KM', datafield: 'totalkm', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname},
						{ text: 'Allowed KM', datafield: 'kmrest', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname},
						{ text: 'Excess KM', datafield: 'excesskm', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname},
						{ text: 'Ex KM Amt', datafield: 'excesskmamt', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname},
						{ text: 'Excess Fuel', datafield: 'excessfuel', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname},
						{ text: 'Ex Fuel Amt', datafield: 'excessfuelamt', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname},
						{ text: 'Excess Km Rate', datafield: 'exkmrte', hidden:true,width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname},
						{ text: 'Excess fuel Rate', datafield: 'fuelrate',hidden:true, width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname},
						{ text: 'Branch Id', datafield: 'branchid',hidden:true, width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname},
						{ text: 'Currency Id', datafield: 'currencyid',hidden:true, width: '6%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname},
						{ text: 'Agmt No', datafield: 'rano', width: '6%'  ,cellclassname: cellclassname,hidden:true},
						{ text: 'Cldocno', datafield: 'cldocno', width: '12%',cellsformat:'d2',hidden:true},
						/* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });

    $('#extraKmGrid').on('rowselect', function (event) 
    		{
    		    // event arguments.
    		    var args = event.args;
    		    // row's bound index.
    		    var rowBoundIndex = event.args.rowindex;
    		    // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
    		    var rowData = event.args.row;
    		    
    		    
    		    var todate=$('#extraKmGrid').jqxGrid('getcellvalue',rowBoundIndex, "todate");
    		  	var docdateval=funDateInPeriodNew(todate);
    		    if(docdateval==0){
    		    	$('#extraKmGrid').jqxGrid('unselectrow', rowBoundIndex);
    		    }
    		});
			
    var rows=$("#extraKmGrid").jqxGrid("getrows");
    var rowcount=rows.length;
    if(rowcount==0){
    	$("#extraKmGrid").jqxGrid("addrow", null, {});	
    }
   
});

	
	
</script>
<div id="extraKmGrid"></div>