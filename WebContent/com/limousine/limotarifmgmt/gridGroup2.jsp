  <%@page import="com.limousine.limotarifmgmt.*" %>
  <%ClsLimoTarifDAO tarifdao=new ClsLimoTarifDAO(); 
  String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
  String id=request.getParameter("id")==null?"0":request.getParameter("id");
  %>
  <script>
  var datagroup2; 
  var id='<%=id%>';
	 if(id=="1"){
		 datagroup2='<%=tarifdao.getGroup2(docno)%>';
	 }
  $(document).ready(function () {
	  
	 
              // prepare the data
              var source =
              {
                  datatype: "json",
                  datafields: [
                            	{name : 'gid' , type: 'string' }, 
                            	{name :'docno',type:'number'}
                            	
       						],
       			localdata: datagroup2,
                  
                 
              };
              
              var dataAdapter = new $.jqx.dataAdapter(source,
              		 {
                  		loadError: function (xhr, status, error) {
  	                    //alert(error);    
  	                    }
  		            });
              
              $("#gridGroup2").jqxGrid(
              {
                  width: '100%',
                  height: 460,
                  source: dataAdapter,
                  selectionmode: 'single',
           		
                 
                  //Add row method
                  handlekeyboardnavigation: function (event) {
                      var cell = $('#gridGroup2').jqxGrid('getselectedcell');
                      if (cell != undefined && cell.datafield == 'gid1' && cell.rowindex == num - 1) {
                          var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                          if (key == 13) {                                                        
                              var commit = $("#gridGroup2").jqxGrid('addrow', null, {});
                              num++;                           
                          }
                      }
                  },
                 
                  columns: [
                         
  							{ text: 'Group', datafield: 'gid', width: '100%' },
  							{ text: 'Doc', datafield: 'docno', width: '100%',hidden:true }
  	              ]
              });

              $('#gridGroup2').on('rowdoubleclick', function (event) 
              {
               var row1=event.args.rowindex;
               document.getElementById("lblgroupdetails").innerText="Tariff of Group "+$('#gridGroup2').jqxGrid('getcellvalue',row1,'gid');
               document.getElementById("hidgroup").value=$('#gridGroup2').jqxGrid('getcellvalue',row1,'docno');
              /*  $("#gridTarifTransfer").jqxGrid({ disabled: false});
   				$("#gridTarifHour").jqxGrid({ disabled: false}); */
   				
   				
               $('#gridtariftransferdiv').load('gridTarifTransfer.jsp?id=1&gid='+$('#gridGroup2').jqxGrid('getcellvalue',row1,'docno')+'&docno='+document.getElementById("docno").value);
               $('#gridtarifhourdiv').load('gridTarifHour.jsp?id=1&gid='+$('#gridGroup2').jqxGrid('getcellvalue',row1,'docno')+'&docno='+document.getElementById("docno").value);
              /*  $("#gridTarifTransfer").jqxGrid({ disabled: true});
   			$("#gridTarifHour").jqxGrid({ disabled: true}); */
              });
  });	
              </script>
              <div id="gridGroup2"></div>
