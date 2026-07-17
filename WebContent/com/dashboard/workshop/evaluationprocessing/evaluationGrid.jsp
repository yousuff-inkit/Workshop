<%@ page import="com.dashboard.workshop.evaluationprocessing.ClsEvaluationProcessingDAO" %>     
<style type="text/css">
  .yellowClass{
       		background-color: #ffc0cb; 
        }
</style>
<% 
 String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
 String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
 ClsEvaluationProcessingDAO DAO=new ClsEvaluationProcessingDAO();
  %>
<script type="text/javascript">
var invoicedata;    
 invoicedata='<%=DAO.getInvoiceData(branchval,fromDate,toDate,cldocno,id)%>';            
 
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
                        {name : 'doc_no' , type: 'String' },
                  		{name : 'voc_no' , type: 'String' },
						{name : 'refname', type: 'String'  },
						{name : 'chassisno', type: 'String'  },
						{name : 'date', type: 'date'  },
						{name : 'engineno', type: 'String'  },
						{name : 'carmaker', type: 'string'  },
						{name : 'billingamt', type: 'number'  },
						{name : 'marketprice',type:'number'},
						{name : 'model',type:'string'},  
						],
				    localdata: invoicedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
     var cellclassname = function (row, column, value, data) {
        if(parseInt(data.invtrno)>0){    
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
    
    $("#jqxEvaluationGrid").jqxGrid(     
    {
        width: '99%',
        height: 550,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 25,
        filterable: true,
        showfilterrow:true,
        enabletooltips:true,  
        columnsresize:true,    
        selectionmode: 'checkbox',        
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
                        { text: 'Doc No', datafield: 'voc_no', width: '7%' , cellclassname:cellclassname},    
                        { text: 'Doc No', datafield: 'doc_no', width: '10%' ,hidden:true, cellclassname:cellclassname},
      					{ text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy', cellclassname:cellclassname},
						{ text: 'Evaluated For', datafield: 'refname', width: '19%' , cellclassname:cellclassname },
						{ text: 'Car Maker', datafield: 'carmaker', width: '12%' , cellclassname:cellclassname},
						{ text: 'Model', datafield: 'model', width: '10%' , cellclassname:cellclassname},
						{ text: 'Chassis No', datafield: 'chassisno', width: '12%' , cellclassname:cellclassname},
						{ text: 'Engine No and Capacity', datafield: 'engineno', width: '12%', cellclassname:cellclassname},
						{ text: 'Evaluated Market Price', datafield: 'marketprice', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname:cellclassname },
						{ text: 'Billing Amt', datafield: 'billingamt', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
			      ]
    });     

    $("#overlay, #PleaseWait").hide(); 
   
});
</script>
<div id="jqxEvaluationGrid"></div>