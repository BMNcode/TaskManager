package bmn.code.TaskManager.repository;

import bmn.code.TaskManager.model.Project;
import bmn.code.TaskManager.model.ProjectStep;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ProjectStepRepo extends CrudRepository<ProjectStep, Long> {
    @Query(
            value = "SELECT * FROM project_steps ps WHERE ps.project_id = ?1 ORDER BY step_id",
            nativeQuery = true)
    Iterable<ProjectStep> findAllProjectId(Long projectId);

    @Query(
            value = "SELECT project_id FROM project_steps ps WHERE ps.step_id = ?1",
            nativeQuery = true)
    Long findProjectId (Long id);

}
