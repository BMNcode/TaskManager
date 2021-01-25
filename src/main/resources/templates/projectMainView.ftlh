<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>

<@c.page>

    <!-- navbar with find project, edit steps, sign out-->
    <nav class="navbar navbar-expand-sm navbar-dark bg-dark rounded">
        <ul class="navbar-nav mr-auto">
            <form class="form-inline" method="get" action="/projectMainView">
                <input class="form-control mr-sm-2" type="text" name="filter" value="${filter}" placeholder="поиск">
                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                <button class="btn btn-success" type="submit">Найти проект</button>
            </form>
        </ul>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item mr-sm-2">
               <form action="/editSteps" method="get">
                   <input type="hidden" name="_csrf" value="${_csrf.token}" />
                   <button class="btn btn-warning text-nowrap" type="submit">Редактировать задачи</button>
               </form>
            </li>
            <li class="nav-item">
               <@l.logout />
            </li>
        </ul>
    </nav>

    <!--add project-->
    <button class="btn btn-success mt-5" data-toggle="collapse" data-target="#hide">Добавить задачу</button>

        <div class="collapse pb-3" id="hide">

            <form class="row row-cols-md-auto g-1 align-items-center pt-5" method="post" action="/add">
                <div class="col-3">
                    <div class="input-group">
                        <input type="text" class="form-control" name="numberProject" placeholder="номер проекта" id="inlineFormInputGroupUsername">
                    </div>
                </div>
                <div class="col-3">
                    <div class="input-group">
                        <input type="text" class="form-control" name="nameProject" placeholder="название проекта" id="inlineFormInputGroupUsername">
                    </div>
                </div>
                <div class="col-3">
                    <div class="input-group">
                        <input type="text" class="form-control" name="revision" placeholder="ревизия" id="inlineFormInputGroupUsername">
                    </div>
                </div>
                <div class="col-3">
                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                    <button type="submit" class="btn btn-success btn-block">Добавить</button>
                </div>
            </form>
        </div>



    <!--list projects-->
    <table class="table table-hover table-bordered mt-5">
      <thead class="table-dark">
        <tr>
          <th scope="col">#</th>
          <th scope="col">Название</th>
          <th scope="col">Ревизия</th>
          <th scope="col">Дата создания</th>
          <th scope="col">Дата завершения</th>
          <th scope="col">Фамилия</th>
          <th scope="col">Статус проекта</th>
          <th scope="col"></th>
        </tr>
      </thead>
        <#list pageProjects.content as project>
          <tbody>
            <#if project.statusProject == "in progress...">
                <tr class="table-secondary" style='cursor: pointer; cursor: hand;' onclick="document.getElementById('${project.projectId}').submit();">
                    <form method="get" action="/steps" id="${project.projectId}">
                        <input type="hidden" name="projectId" value="${project.projectId}" />
                        <input type="hidden" name="_csrf" value="${_csrf.token}" />
                            <td class="align-middle text-nowrap"
                                style='cursor: pointer; cursor: hand;' onclick="document.getElementById('${project.projectId}').submit();">
                                    ${project.numberProject}
                            </td>
                            <td class="text-center align-middle"
                                style='cursor: pointer; cursor: hand; word-wrap: break-word;min-width: 160px;max-width: 160px;' onclick="document.getElementById('${project.projectId}').submit();">
                                    ${project.nameProject}
                            </td>
                            <td class="text-center align-middle"
                                style='cursor: pointer; cursor: hand; word-wrap: break-word;min-width: 160px;max-width: 160px;' onclick="document.getElementById('${project.projectId}').submit();">
                                    ${project.revision}
                            </td>
                            <td class="align-middle text-nowrap"
                                style='cursor: pointer; cursor: hand;' onclick="document.getElementById('${project.projectId}').submit();">
                                    ${project.dateCreate}
                            </td>
                            <td class="align-middle text-nowrap"
                                style='cursor: pointer; cursor: hand;' onclick="document.getElementById('${project.projectId}').submit();">
                                    ${project.dateFinishing}
                            </td>
                            <td class="align-middle"
                                style='cursor: pointer; cursor: hand;' onclick="document.getElementById('${project.projectId}').submit();">
                                    ${project.developerName}
                            </td>
                            <td class="align-middle text-nowrap"
                                style='cursor: pointer; cursor: hand;' onclick="document.getElementById('${project.projectId}').submit();">
                                    ${project.statusProject}
                            </td>
                    </form>
                            <td class="align-middle text-nowrap">
                                <form method="post" action="/deleteProject">
                                    <input type="hidden" name="id" value="${project.projectId}" />
                                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                    <button type="submit" rel="tooltip"
                                        class="btn btn-outline-danger btn-just-icon btn-sm"
                                        data-original-title="" title="">
                                            <i class="material-icons">delete</i>
                                    </button>
                                </form>
                            </td>
                </tr>
            <#else>
                <tr class="table-success" >
                    <form method="get" action="/steps" id="${project.projectId}">
                        <input type="hidden" name="projectId" value="${project.projectId}" />
                        <input type="hidden" name="_csrf" value="${_csrf.token}" />
                            <td class="align-middle text-nowrap"
                                style='cursor: pointer; cursor: hand;' onclick="document.getElementById('${project.projectId}').submit();">
                                    ${project.numberProject}
                            </td>
                            <td class="text-center align-middle"
                                style='cursor: pointer; cursor: hand; word-wrap: break-word;min-width: 160px;max-width: 160px;' onclick="document.getElementById('${project.projectId}').submit();">
                                    ${project.nameProject}
                            </td>
                            <td class="text-center align-middle"
                                style='cursor: pointer; cursor: hand; word-wrap: break-word;min-width: 160px;max-width: 160px;' onclick="document.getElementById('${project.projectId}').submit();">
                                    ${project.revision}
                            </td>
                            <td class="align-middle text-nowrap"
                                style='cursor: pointer; cursor: hand;' onclick="document.getElementById('${project.projectId}').submit();">
                                    ${project.dateCreate}
                            </td>
                            <td class="align-middle text-nowrap"
                                style='cursor: pointer; cursor: hand;' onclick="document.getElementById('${project.projectId}').submit();">
                                    ${project.dateFinishing}
                            </td>
                            <td class="align-middle"
                                style='cursor: pointer; cursor: hand;' onclick="document.getElementById('${project.projectId}').submit();">
                                    ${project.developerName}
                            </td>
                            <td class="align-middle text-nowrap"
                                style='cursor: pointer; cursor: hand;' onclick="document.getElementById('${project.projectId}').submit();">
                                    ${project.statusProject}
                            </td>
                    </form>
                            <td class="align-middle text-nowrap">
                                <form method="post" action="/deleteProject">
                                    <input type="hidden" name="id" value="${project.projectId}" />
                                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                    <button type="submit" rel="tooltip"
                                        class="btn btn-outline-danger btn-just-icon btn-sm"
                                        data-original-title="" title="">
                                            <i class="material-icons">delete</i>
                                    </button>
                                </form>

                            </td>
                </tr>
            </#if>
          </tbody>
        <#else>
            <p class="text-center h1">No projects</p>
        </#list>
    </table>

    <#if pageProjects.getTotalPages() gt 7>
        <#assign
            totalPages = pageProjects.getTotalPages()
            pageNumber = pageProjects.getNumber() + 1

            head = (pageNumber > 4)?then([1, -1], [1, 2, 3])
            tail = (pageNumber < totalPages - 3)?then([-1, totalPages], [totalPages - 2, totalPages -1, totalPages])
            bodyBefore = (pageNumber > 4 && pageNumber < totalPages - 1)?then([pageNumber - 2, pageNumber - 1], [])
            bodyAfter = (pageNumber > 2 && pageNumber < totalPages - 3)?then([pageNumber + 1, pageNumber + 2], [])

            body = head + bodyBefore +  (pageNumber > 3 && pageNumber < totalPages - 2)?then([pageNumber], []) + bodyAfter + tail
        >
    <#else>
        <#assign body = 1..pageProjects.getTotalPages()>
    </#if>

    <div>
      <ul class="pagination">
        <li class="page-item disabled">
            <a class="page-link" href="#" tabindex="-1">Страницы</a>
        </li>
        <#list body as p>
            <#if (p - 1) == pageProjects.getNumber()>
                <li class="page-item active">
                    <a class="page-link" href="#" tabindex="-1">${p}</a>
                </li>
            <#elseif p == -1>
                <li class="page-item disabled">
                    <a class="page-link" href="#" tabindex="-1">...</a>
                </li>
            <#else>
                <li class="page-item">
                    <a class="page-link" href="${url}?page=${p - 1}" tabindex="-1">${p}</a>
                </li>
            </#if>
        </#list>
      </ul>
    </div>


</@c.page>