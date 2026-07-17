<%@page import="com.dashboard.marketing.residualvaluemaster.*" %>
<%
ClsResidualValueMasterDAO masterdao=new ClsResidualValueMasterDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String type=request.getParameter("type")==null?"":request.getParameter("type");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String brand=request.getParameter("brand")==null?"":request.getParameter("brand");
String model=request.getParameter("model")==null?"":request.getParameter("model");
String yom=request.getParameter("yom")==null?"":request.getParameter("yom");
String brandid=request.getParameter("brandid")==null?"":request.getParameter("brandid");
String modelid=request.getParameter("modelid")==null?"":request.getParameter("modelid");
String yomid=request.getParameter("yomid")==null?"":request.getParameter("yomid");
%>
<script type="text/javascript">
var residualgriddata;
var exceldata;
var id='<%=id%>';
if(id=="1"){
	residualgriddata='<%=masterdao.getResidualGridData(id,type,branch,brand,model,yom,brandid,modelid,yomid)%>';
}
$('#btnExcel').click(function(){
	if(document.getElementById("rdoview").checked==true){
		exceldata='<%=masterdao.getExcelData()%>';
		JSONToCSVCon(exceldata, 'Residual Value Excel', true);		
	}
});
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no' , type: 'number' },
						{name : 'brandid', type: 'String'  },
						{name : 'modelid', type: 'string'    },
						{name : 'yomid', type: 'string'  },
						{name : 'brand', type: 'string'  },
						{name : 'model', type: 'string'  },
						{name : 'yom', type: 'number'  },
						{name : 'months', type: 'number'  },
						{name : 'km',type:'number'},
						{name : 'residualvalue',type:'number'},
						{name : 'residualdocno',type:'number'}
						],
				    localdata: residualgriddata,
        
        
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
    
    
    $("#residualValueGrid").jqxGrid(
    {
        width: '98%',
        height: 510,
        source: dataAdapter,
        showaggregates:true,
        columnsresize:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlecell',
        pagermode: 'default',
       sortable:false,
       editable:true,
        columns: [
               
						{ text: 'Sr. No.',datafield: '',columntype:'number', editable:false,width: '10%', cellsrenderer: function (row, column, value) {
	                               return "<div style='margin:4px;'>" + (value + 1) + "</div>";
                            }   },
						{ text: 'Brand ID', datafield: 'brandid', width: '8%',hidden:true, editable:false},
						{ text: 'Model ID', datafield: 'modelid', width: '8%',hidden:true, editable:false},
						{ text: 'Yom ID', datafield: 'yomid', width: '8%',hidden:true, editable:false},
						{ text: 'Brand', datafield: 'brand', width: '25%', editable:false}, 
						{ text: 'Model', datafield: 'model', width: '25%', editable:false},
						{ text: 'Yom', datafield: 'yom', width: '10%', editable:false},
						{ text: 'Months',datafield:'months',width:'10%', editable:false},
						{ text: 'Kms',datafield:'km',width:'10%', editable:false},
						{ text: 'Residual Value',datafield:'residualvalue',width:'10%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{ text: 'Residual Docno',datafield:'residualdocno',width:'10%',hidden:true, editable:false}
					]

    });

	$('#residualValueGrid').on('rowdoubleclick', function (event) 
			{ 
				var args = event.args;
				// row's bound index.
				var boundIndex = event.args.rowindex;
				// row's visible index.
				var visibleIndex = event.args.visibleindex;
				// right click.
				var rightclick = event.args.rightclick; 
				// original event.
				var ev = event.args.originalEvent;
				
	});
});

	
	
</script>
<div id="residualValueGrid"></div>