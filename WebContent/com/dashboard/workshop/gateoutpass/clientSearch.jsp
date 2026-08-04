<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

    <script type="text/javascript">
    $(document).ready(function () {
        // Initialization if needed
    }); 

    function loadSearch() {
        var clientname = document.getElementById("txtclname").value;
        var cldocno = document.getElementById("txtcldocno").value;
        var chk = 1;
        
        getdata(clientname, cldocno, chk);
    }
    
    function getdata(clientname, cldocno, chk){
        // Upgraded to use encodeURIComponent for safe parameter passing
        var url = 'clientSearchGrid.jsp' + 
                  '?clientname=' + encodeURIComponent(clientname) + 
                  '&cldocno=' + encodeURIComponent(cldocno) + 
                  '&chk=' + chk;
                  
         $("#clientSearchDiv").load(url);
    }
    </script>

<style>
*{
    box-sizing:border-box;
}

html,body{
    margin:0;
    padding:0;
    width:100%;
    max-width:100%;
    background:#fff;
    font-family:Segoe UI,Tahoma,sans-serif;
    overflow-x:hidden;
}

#search{
    padding:10px;
    background:#fff;
    width:100%;
    max-width:100%;
}

.search-panel{
    background:#fff;
    border:1px solid #d9d9d9;
    border-radius:4px;
    padding:12px;
    margin-bottom:10px;
    width:100%;
    max-width:100%;
    display:flex;
    flex-wrap:wrap;
    align-items:flex-end;
    gap:10px 14px;
}

.field-group{
    display:flex;
    flex-direction:column;
    flex:1 1 140px;
    min-width:110px;
    max-width:100%;
}

.field-group.grow-2{
    flex:2 1 200px;
}

.lbl-right{
    text-align:left;
    font-size:12px;
    font-weight:500;
    color:#333;
    margin-bottom:4px;
    white-space:nowrap;
}

.search-input{
    height:26px;
    width:100%;
    max-width:100%;
    border:1px solid #cfcfcf;
    border-radius:3px;
    padding:2px 6px;
    font-size:12px;
}

.btn-group{
    flex:0 0 auto;
}

.grid-container{
    background:#fff;
    border:1px solid #d9d9d9;
    border-radius:4px;
    overflow:hidden;
    width:100%;
    max-width:100%;
}
</style>
</head>
<body>

<div id="search">

    <div class="search-panel">
        
        <div class="field-group grow-2">
            <span class="lbl-right">Name</span>
            <input type="text"
                   id="txtclname"
                   name="txtclname"
                   class="search-input"
                   autocomplete="off"
                   value='<s:property value="txtclname"/>'>
                   
            <!-- Hidden doc number input -->
            <input type="hidden" 
                   id="txtcldocno" 
                   name="txtcldocno" 
                   value='<s:property value="txtcldocno"/>'>
        </div>

        <div class="btn-group">
            <input
                type="button"
                id="btnsearchClient"
                name="btnsearchClient"
                class="myButton"
                onclick="loadSearch();"
                value="Search"
                style="
                    width:100px;
                    height:28px;
                    background:#205fd3;
                    color:#fff;
                    border:1px solid #205fd3;
                    border-radius:4px;
                    font-size:12px;
                    font-weight:600;
                    cursor:pointer;">
        </div>

    </div>

    <div class="grid-container">
        <div id="clientSearchDiv">
           <jsp:include page="clientSearchGrid.jsp"></jsp:include> 
        </div>
    </div>

</div>

</body>
</html>