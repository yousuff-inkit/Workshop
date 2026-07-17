<%@page import="com.dashboard.limousine.limobookingfollowup.*" %>
<%ClsLimoBookFollowupDAO followdao=new ClsLimoBookFollowupDAO(); 
String bookdocno=request.getParameter("bookdocno")==null?"0":request.getParameter("bookdocno");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>
 <script type="text/javascript">
 var id='<%=id%>';
 var detailsdata;
var BookFollowuprexcel;
 if(id=="1"){
	 detailsdata='<%=followdao.getFollowupDetailData(bookdocno,id)%>';
         BookFollowuprexcel='<%=followdao.excelFollowupsubData(bookdocno,id)%>';
 }
          
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                 			{name : 'date', type: 'date'  },
     						{name : 'user', type: 'String'},
     						{name : 'remarks', type: 'String'},
     						{name : 'fdate' , type : 'date'}
     						
                          	],
                          	localdata: detailsdata,
                          	       
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );
            $("#followupDetailGrid").jqxGrid(
            { 
            	
            	
            	width: '98%',
                height: 102,
                source: dataAdapter,
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:false,
     					
                columns: [
						
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
							 { text: 'User', datafield: 'user', width: '18%' },
							 { text: 'Follow-Up Date', datafield: 'fdate', width: '10%',cellsformat:'dd.MM.yyyy'},	
							 { text: 'Remarks', datafield: 'remarks', width: '62%' }
					
					]
            });
           
        });
        
    </script>
    <div id="followupDetailGrid"></div>