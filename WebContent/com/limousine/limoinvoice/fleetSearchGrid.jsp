
<%@page import="com.limousine.limoinvoice.*" %>
<%ClsLimoInvoiceDAO invoicedao=new ClsLimoInvoiceDAO();%>
<%String gridrowindex=request.getParameter("gridrowindex")==null?"0":request.getParameter("gridrowindex");
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String fleetname=request.getParameter("fleetname")==null?"":request.getParameter("fleetname");
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
String brand=request.getParameter("brand")==null?"":request.getParameter("brand");
String model=request.getParameter("model")==null?"":request.getParameter("model");
String group=request.getParameter("group")==null?"":request.getParameter("group");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
 <script type="text/javascript">
 var gridrowindex='<%=gridrowindex%>';
 var fleetsearchdata='<%=invoicedao.getFleetSearchData(fleetno,fleetname,regno,brand,model,group,id)%>';
 var id='<%=id%>';
   $(document).ready(function () { 	
       	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [ 
                            {name :'fleet_no',type:'number'},
     						{name :'flname', type: 'string'  },
     						{name :'reg_no', type: 'number'},
     						{name : 'brand',type:'string'},
     						{name : 'model',type:'string'},
     						{name : 'gname',type:'string'}

                 ],               
               localdata:fleetsearchdata,
               
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

            
            
            $("#fleetSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                selectionmode: 'singlerow',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
 
				},
                
                columns: [
                            
                            {text: 'Fleet No',datafield:'fleet_no',width:'10%'},					
                            { text: 'Reg No',datafield:'reg_no',width:'10%'},
                            { text: 'Fleet Name',datafield:'flname',width:'35%'},
                            { text: 'Brand',datafield:'brand',width:'15%'},
                            { text:'Model',datafield:'model',width:'15%'},
                            {text:'Group',datafield:'gname',width:'15%'}
	              ]
            });
       $('#fleetSearchGrid').on('rowdoubleclick', function (event) {
    	   var row1=event.args.rowindex;
    		$('#limoInvoiceGrid').jqxGrid('setcellvalue',gridrowindex,'flname',$('#fleetSearchGrid').jqxGrid('getcellvalue',row1,'flname'));
    		$('#limoInvoiceGrid').jqxGrid('setcellvalue',gridrowindex,'fleet_no',$('#fleetSearchGrid').jqxGrid('getcellvalue',row1,'fleet_no'));
    		$('#limoInvoiceGrid').jqxGrid('setcellvalue',gridrowindex,'reg_no',$('#fleetSearchGrid').jqxGrid('getcellvalue',row1,'reg_no'));
    		$("#limoInvoiceGrid").jqxGrid("addrow", null, {});
    		$('#fleetwindow').jqxWindow('close');
    	  
       });
       
        });
    </script>
    <div id="fleetSearchGrid"></div>
