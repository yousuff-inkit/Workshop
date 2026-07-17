<%@page import="com.dashboard.analysis.depreciationanalysis.ClsDepreciationAnalysisDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%ClsDepreciationAnalysisDAO DAO= new ClsDepreciationAnalysisDAO(); %>
<% String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate");
   String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate");
   String branch = request.getParameter("branchval")==null?"NA":request.getParameter("branchval");
   String check = request.getParameter("check")==null?"0":request.getParameter("check");%> 

<script type="text/javascript">
	var temp='<%=branch%>';
	var data;
	
	if(temp!='NA')
	{
		 data= '<%=DAO.depreciationAnalysisGridLoading(branch,fromDate,toDate,check)%>';
		 var dataExcelExport='<%=DAO.depreciationAnalysisExcelExport(branch,fromDate,toDate,check)%>';
	}

$(document).ready(function () {
   
	var rendererstring=function (aggregates){
		var value=aggregates['sum'];
		if(typeof(value) == "undefined"){
			value=0.00;
		}
		return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
	   }

	var rendererstring1=function (aggregates){
		var value1=aggregates['sum1'];
		return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
	   }

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
       
                  		{name : 'agreement' , type: 'string' },
						{name : 'type' , type: 'string' },
						{name : 'client', type: 'string'  },
						{name : 'fleetno', type: 'string'  },
						{name : 'regno', type: 'string'  },
						{name : 'platecode', type: 'string'  },
						{name : 'brand', type: 'string'  },
						{name : 'model', type: 'string'  },
						{name : 'leasefromdate', type: 'date'  },
						{name : 'leasetodate', type: 'date'  },
						{name : 'posteddate', type: 'date'  },
						{name : 'vehiclecost', type: 'number'  },
						{name : 'residual', type: 'number'  },
						{name : 'numberofdays', type: 'number'  },
						{name : 'totaldepriciated', type: 'number'  },
						{name : 'opndepriciated', type: 'number'  },
						{name : 'posted', type: 'number'  },
						{name : 'balance', type: 'number'  }
						],
				    localdata: data,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	 });  	        
    
    $("#depreciationAnalysisGridID").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        editable: false,
        sortable:true,
        showaggregates: true,
        showstatusbar:true,
        rowsheight:25,
        statusbarheight:25,
				
        columns: [
            
						{ text: 'Agreement', datafield: 'agreement', width: '6%' },
						{ text: 'Type', datafield: 'type' , width: '9%' },
						{ text: 'Client', datafield: 'client' , width: '16%' },
						{ text: 'Fleet', datafield: 'fleetno' , width: '6%' },
						{ text: 'Reg No', datafield: 'regno' , width: '5%' },
						{ text: 'Plate Code', datafield: 'platecode', width: '5%' },
						{ text: 'Brand', datafield: 'brand', width: '10%' },
						{ text: 'Model', datafield: 'model', width: '9%' },
						{ text: 'From', datafield: 'leasefromdate' , cellsformat: 'dd.MM.yyyy' ,  width: '6%' },
						{ text: 'To', datafield: 'leasetodate' , cellsformat: 'dd.MM.yyyy' ,  width: '6%' },
						{ text: 'Posted Till', datafield: 'posteddate' , cellsformat: 'dd.MM.yyyy' , width: '6%' },
						{ text: 'Vehicle Cost', datafield: 'vehiclecost' , cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right' },
						{ text: 'Residual Value', datafield: 'residual' , cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right' },
						{ text: 'No. of Days', datafield: 'numberofdays', cellsformat: 'd2', width: '8%', cellsalign: 'center', align: 'center', aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
						{ text: 'Total Depriciation', datafield: 'totaldepriciated', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
						{ text: 'Opening Depriciation', datafield: 'opndepriciated', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
						{ text: 'Posted', datafield: 'posted', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
						{ text: 'Balance', datafield: 'balance', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
						]
    
    });

	$("#overlay, #PleaseWait").hide();
	
});

</script>
<div id="depreciationAnalysisGridID"></div>