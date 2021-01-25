<#macro login path>
        <form action="${path}" method="post">
            <div class="row justify-content-center align-items-center" style="height:95vh">
                <div class="col-4">
                    <div class="d-grid gap-3">
                        <form action="" autocomplete="off">
                            <div class="form-group">
                                <input type="text" name="username" class="form-control" placeholder="User name" />
                            </div>
                            <div class="form-group">
                                <input type="password" name="password" class="form-control" placeholder="Password" />
                            </div>
                            <input type="hidden" name="_csrf" value="${_csrf.token}" />
                            <button class="btn btn-primary btn-block" type="submit">Sign In</button>
                        </form>
                    </div>
                </div>
            </div>
        </form>
</#macro>

<#macro logout>
         <form action="/logout" method="post">
             <input type="hidden" name="_csrf" value="${_csrf.token}" />
             <button class="btn btn-outline-success text-nowrap" type="submit">Sign Out</button>
         </form>
</#macro>