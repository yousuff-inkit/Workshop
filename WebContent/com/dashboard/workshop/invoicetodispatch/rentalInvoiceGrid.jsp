<%@page import="com.dashboard.workshop.invoicetodispatch.*" %>
<%ClsInvoiceDispatchDAO cid=new ClsInvoiceDispatchDAO(); %>
<% 
 String branchval = request.getParameter("branchval")==null?"":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"":request.getParameter("todate").trim();
 String cldocno = request.getParameter("cldocno")==null?"":request.getParameter("cldocno").trim();
 String id = request.getParameter("id")==null?"":request.getParameter("id").trim();
%>

<script type="text/javascript">
var id='<%=id%>';
var invoicedata=[];
if(id=='1')
{ 
  invoicedata='<%= cid.invoicelist(branchval,fromDate,toDate,cldocno,id)%>';
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
                      	{name : 'invdocno' , type: 'number' },
                      	{name : 'invvocno',type:'number'},
                  		{name : 'jobdocno' , type: 'number' },
                  		{name : 'jobvocno',type: 'number'},
						{name : 'estdocno', type: 'number'  },
						{name : 'estvocno', type: 'number'    },
						{name : 'gatedocno', type: 'number'  },
						{name : 'gatevocno', type: 'number'  },
						{name : 'date', type: 'date'  },
						{name : 'branch', type: 'string'  },
						{name : 'account', type: 'number'  },
						{name : 'acname',type:'String'},
						{name : 'taxtotal', type: 'string'  },
						{name : 'brhid',type:'String'},
						{name : 'mailid',type:'String'},
						{name : 'actype',type:'String'},
						{name : 'addition',type:'String'},
						],
				    localdata: invoicedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    $("#rentalInvoiceGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	//$('#rentalInvoiceGrid').jqxGrid({ sortable: true});
    	});
 /*    var cellclassname = function (row, column, value, data) {
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
    
    
    $("#rentalInvoiceGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 25,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
        pagermode: 'default',
      	sortable:true,
        columns: [
                  
						{ text: 'SL#', sortable: false, filterable: false, editable: false,groupable: false, draggable: false, resizable: false,
						    datafield: 'sl', columntype: 'number', width: '5%',
						    cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						    }  
						},
                        { text: 'Original Doc No', datafield: 'invdocno', width: '7.5%',hidden:true  },
                        { text: 'Doc No', datafield: 'invvocno', width: '7.5%'},
                        { text: 'Original Job No', datafield: 'jobdocno', width: '7.5%',hidden:true  },
                        { text: 'Job No', datafield: 'jobvocno', width: '7.5%'},
                        { text: 'Original Est No', datafield: 'estdocno', width: '7.5%',hidden:true  },
                        { text: 'Est No', datafield: 'estvocno', width: '7.5%'},
                        { text: 'Original Gate No', datafield: 'gatedocno', width: '7.5%',hidden:true  },
                        { text: 'GIP No', datafield: 'gatevocno', width: '7.5%'},
                        { text: 'Branch',datafield:'branch',width:'10%'},
                        { text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy'},
						
						{ text: 'Account', datafield: 'account', width: '5%'   },
						{ text: 'Account Name', datafield: 'acname', width: '27%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
						{ text: 'Mail Id', datafield: 'mailid', width: '12%',hidden:true},
						{ text: 'Amount', datafield: 'taxtotal', width: '12%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
						{ text: 'branch id', datafield: 'brhid', width: '12%',hidden:true},
						
						{ text: 'Ac Type', datafield: 'actype', width: '12%',hidden:true},
						{ text: 'Addition', datafield: 'addition', width: '12%',hidden:true},
					]

    });
    
    
});

	
</script>
<div id="rentalInvoiceGrid"></div>