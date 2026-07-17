<%@page import="com.limousine.limobooking.*" %>
<%
ClsLimoBookingDAO limodao=new ClsLimoBookingDAO();
%> 

 <script type="text/javascript">
 
 var searchdata='<%=limodao.getSearchData()%>'; 
	 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'doc_no', type: 'String'  },
     						{name : 'cldocno', type: 'String'  },
     						{name : 'refname', type: 'String'  },
     						{name : 'date',type:'date'},
     						{name : 'per_mob',type:'string'},
     						{name : 'dlno',type:'string'},
     						{name : 'guest',type:'string'},
     						{name : 'guestcontactno',type:'string'},
     						{name : 'guestno',type:'string'},
     						{name : 'hidchknewguest',type:'string'},
     						{name : 'description',type:'string'}
     						
      					
                          	],
                          	localdata: searchdata,
                          //	 url: url1,
          
				
                
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
            $("#mainSearch").jqxGrid(
            {
                width: '100%',
                height: 370,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            	filterable:true,
            	showfilterrow:true,
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Date',datafield:'date',cellsformat:'dd.MM.yyyy',width:'10%'},
					{ text: 'Client ID', datafield: 'cldocno', width: '50%',hidden:true },
					{ text: 'Client', datafield: 'refname', width: '30%'},
					{ text: 'Mobile',datafield:'per_mob',width:'20%'},
					{ text: 'Guest', datafield: 'guest', width: '30%'},
					{ text: 'License',datafield:'dlno',width:'10%',hidden:true},
					{ text: 'Guest Contact No',datafield:'guestcontactno',width:'10%',hidden:true},
					{ text: 'Guest No',datafield:'guestno',width:'10%',hidden:true},
					{ text: 'New Guest',datafield:'hidchknewguest',width:'10%',hidden:true},
					{ text: 'Description',datafield:'description',width:'10%',hidden:true},
					
					]
            });
    
			$('#mainSearch').on('rowdoubleclick', function (event) 
				{ 
				var rowindex1=event.args.rowindex;
	            document.getElementById("docno").value=$('#mainSearch').jqxGrid('getcellvalue',rowindex1,'doc_no');
	            document.getElementById("client").value=$('#mainSearch').jqxGrid('getcellvalue',rowindex1,'refname');
	            document.getElementById("hidclient").value=$('#mainSearch').jqxGrid('getcellvalue',rowindex1,'cldocno');
	            var details="Mobile: "+$('#mainSearch').jqxGrid('getcellvalue',rowindex1,'per_mob')+" License: "+$('#mainSearch').jqxGrid('getcellvalue',rowindex1,'dlno');
	            document.getElementById("clientdetails").value=details;
	            document.getElementById("hidguest").value=$('#mainSearch').jqxGrid('getcellvalue',rowindex1,'guestno');
	            document.getElementById("guest").value=$('#mainSearch').jqxGrid('getcellvalue',rowindex1,'guest');
	            document.getElementById("guestcontactno").value=$('#mainSearch').jqxGrid('getcellvalue',rowindex1,'guestcontactno');
	            $('#date').jqxDateTimeInput('val',$('#mainSearch').jqxGrid('getcellvalue',rowindex1,'date'));
	            document.getElementById("hidchknewguest").value=$('#mainSearch').jqxGrid('getcellvalue',rowindex1,'hidchknewguest');
	            document.getElementById("description").value=$('#mainSearch').jqxGrid('getcellvalue',rowindex1,'description');
	            setValues();
				$('#window').jqxWindow('close');
			}); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="mainSearch"></div>
    