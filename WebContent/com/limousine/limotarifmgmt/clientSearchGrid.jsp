<%@page import="com.limousine.limotarifmgmt.*" %>
<%ClsLimoTarifDAO tarifdao=new ClsLimoTarifDAO();
String name=request.getParameter("name")==null?"":request.getParameter("name");
String mobile=request.getParameter("mobile")==null?"":request.getParameter("mobile");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String tariftype=request.getParameter("tariftype")==null?"":request.getParameter("tariftype");
%>
 <script type="text/javascript">
 var id='<%=id%>';
 var tariftype='<%=tariftype%>'
 var clientdata;
 if(id=="1"){
	 clientdata='<%=tarifdao.getClient(name,mobile,id,tariftype)%>';
 }
        $(document).ready(function () { 	

        	
        	// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'cldocno', type: 'int'},
     						{name : 'refname', type: 'string'},
     						{name : 'address',type:'string'},
     						{name : 'per_mob',type:'string'}
     											
                 ],               
               localdata:clientdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
        	
                                      
            };
            $("#clientSearchGrid").on("bindingcomplete", function (event) {
            	// your code here.
            	 if(tariftype=="corporate"){
        			 $('#clientSearchGrid').jqxGrid('hidecolumn','address');
        			 $('#clientSearchGrid').jqxGrid('hidecolumn','per_mob');
        			 $('#clientSearchGrid').jqxGrid('setcolumnproperty','cldocno','width','20%');
        			 $('#clientSearchGrid').jqxGrid('setcolumnproperty','refname','width','80%');
        		 }
        		 else if(tariftype=="client"){
        			 $('#clientSearchGrid').jqxGrid('showcolumn','address');
        			 $('#clientSearchGrid').jqxGrid('showcolumn','per_mob');
        			 $('#clientSearchGrid').jqxGrid('setcolumnproperty','cldocno','width','10%');
        			 $('#clientSearchGrid').jqxGrid('setcolumnproperty','refname','width','30%');
        		 }
            });
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
            			loadComplete: function () {
                    		 $("#loadingImage1").css("display", "none");
                    		 if(tariftype=="corporate"){
                    			 $('#clientSearchGrid').jqxGrid('hidecolumn','address');
                    			 $('#clientSearchGrid').jqxGrid('hidecolumn','per_mob');
                    			 $('#clientSearchGrid').jqxGrid('setcolumnproperty','cldocno','width','20%');
                    			 $('#clientSearchGrid').jqxGrid('setcolumnproperty','refname','width','80%');
                    		 }
                    		 else if(tariftype=="client"){
                    			 $('#clientSearchGrid').jqxGrid('showcolumn','address');
                    			 $('#clientSearchGrid').jqxGrid('showcolumn','per_mob');
                    			 $('#clientSearchGrid').jqxGrid('setcolumnproperty','cldocno','width','10%');
                    			 $('#clientSearchGrid').jqxGrid('setcolumnproperty','refname','width','30%');
                    		 }
                		},
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#clientSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
               // editable: true,
                altRows: true,
                /* showfilterrow: true, */
                /* filterable: true, */ 
                sortable: true,
                selectionmode: 'singlerow',
               // pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                  /*   var cell = $('#invAcSearch').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'description' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#invAcSearch").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    } */
                },
                
  
                
                columns: [
                           	{ text:'Doc No',datafield:'cldocno',width:'10%'},
                           	{ text:'Name',datafield:'refname',width:'30%'},
                           	{ text:'Address',datafield:'address',width:'40%'},
                           	{ text:'Mobile',datafield:'per_mob',width:'20%'}
												
	              		]
            });
       	$('#clientSearchGrid').on('rowdoubleclick', function (event) {
            	var rowindex=event.args.rowindex;
            	document.getElementById("tarifclient").value=$('#clientSearchGrid').jqxGrid('getcellvalue',rowindex,'refname');
            	document.getElementById("hidtarifclient").value=$('#clientSearchGrid').jqxGrid('getcellvalue',rowindex,'cldocno');
                $('#clientwindow').jqxWindow('close');
        });
            
      });
    </script>
    <div id="clientSearchGrid"></div>
 
