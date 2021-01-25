package bmn.code.TaskManager.repository;

import bmn.code.TaskManager.model.ProjectComment;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ProjectCommentRepo extends CrudRepository<ProjectComment, Long> {

    @Query(
            value = "SELECT project_id FROM project_steps ps WHERE ps.step_id = ?1",
            nativeQuery = true)
    Long findProjectId (Long id);

    @Query(
            value = "SELECT * FROM project_comments pc WHERE pc.project_id = ?1 ORDER BY comment_id",
            nativeQuery = true)
    Iterable<ProjectComment> findAllProjectId(Long projectId);

}
