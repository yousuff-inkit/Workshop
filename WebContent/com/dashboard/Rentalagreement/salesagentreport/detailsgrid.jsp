 
<%@ page import="com.dashboard.rentalagreement.salesagentreport.ClssalesagentReportDAO"

%>

<% 
String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();

 String hidrag = request.getParameter("hidrag")==null?"0":request.getParameter("hidrag").trim();
 String hidsag = request.getParameter("hidsag")==null?"0":request.getParameter("hidsag").trim();
 String clstatuss = request.getParameter("clstatuss")==null?"NA":request.getParameter("clstatuss").trim();
 
  ClssalesagentReportDAO DAO=new ClssalesagentReportDAO();
  %>
 
  <style type="text/css">

  .yellowClass
        {
        
       
       background-color: #ffc0cb; 
        /*   background-color: #eedd82;  */
        }
</style>


<script type="text/javascript">
 var temp4='<%=branchval%>';
//alert(temp4);
var data;
 var exceldata;
if(temp4!='NA')
{ 
	exceldata='<%=DAO.salesagentReports(branchval,fromDate,toDate,type,hidrag,hidsag,clstatuss)%>';   
	 data='<%=DAO.salesagentReport(branchval,fromDate,toDate,type,hidrag,hidsag,clstatuss)%>';   
 


}
else
{
      
	data;
	
	} 
$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
     	var rendererstring1=function (aggregates){
     	var value1=aggregates['sum1'];
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Total" + '</div>';
     }

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                      {name : 'doc_no' , type: 'int' },
                  		{name : 'rano' , type: 'int' },
					 
						/* {name : 'branch', type: 'int'    }, */
						{name : 'mrano', type: 'String'  },
						{name : 'fromdate', type: 'date'  },
						{name : 'todate', type: 'date'  },
						{name : 'date', type: 'date'  },
		 
						{name : 'acno', type: 'String'  },
						{name : 'acname', type: 'string'  },
						{name : 'amount', type: 'number'  },
						{name : 'sadocno' , type: 'int' },
						{name : 'saname', type: 'String'  },
						
						
						{name :'rent',type:'number'},
						{name :'accchg',type:'number'},
						{name :'salik',type:'number'},
						{name :'traffic',type:'number'},
						{name :'other',type:'number'},
						
						{name :'inschg',type:'number'},
						
						
						],
				    localdata: data,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
     var cellclassname = function (row, column, value, data) {
        if(parseInt(data.status)==7){
        	return "yellowClass"; 
        }
        else{
        	
        };
          }; 
          
          
         
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#detailgrid").jqxGrid(
    {
        width: '98%',
        height: 525,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 25,

        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       sortable:true,
        columns: [
                  
					{ text: 'SL#', sortable: false, filterable: false, editable: false, cellclassname:cellclassname,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '3%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  }, 
                        { text: 'Doc No', datafield: 'doc_no', width: '5%' , cellclassname:cellclassname},  
      					{ text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy'  , cellclassname:cellclassname},
      					{ text: 'Ref No', datafield: 'sadocno', width: '5%' , cellclassname:cellclassname },
						{ text: 'Ref Name', datafield: 'saname', width: '20%' , cellclassname:cellclassname},
						{ text: 'RA No', datafield: 'rano', width: '5%' , cellclassname:cellclassname },
					 
						{ text: 'MRA NO', datafield: 'mrano', width: '8%' , cellclassname:cellclassname},
						{ text: 'From Date', datafield: 'fromdate', width: '7%',cellsformat:'dd.MM.yyyy'  , cellclassname:cellclassname},
						{ text: 'To Date', datafield: 'todate', width: '7%',cellsformat:'dd.MM.yyyy', cellclassname:cellclassname  },
						{ text: 'Account', datafield: 'acno', width: '6%'  , cellclassname:cellclassname },
						{ text: 'Account Name', datafield: 'acname', width: '18%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 , cellclassname:cellclassname},
						{ text: 'Amount', datafield: 'amount', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
					 
						
						{ text: 'Rental Sum', datafield: 'rent', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'Acc Sum', datafield: 'accchg', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'Salik Amt', datafield: 'salik', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname:cellclassname },
						{ text: 'Traffic Amt', datafield: 'traffic', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
					
			
						{ text: 'Insurance Charges',datafield: 'inschg', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname:cellclassname},
						
						{ text: 'Other Charges',datafield: 'other', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname:cellclassname},
						
					]

    });

    $("#overlay, #PleaseWait").hide(); 
    var rows=$("#detailgrid").jqxGrid("getrows");
    var rowcount=rows.length;
    if(rowcount==0){
    	$("#detailgrid").jqxGrid("addrow", null, {});	
    }
   
});

	
	
</script>
<div id="detailgrid"></div>