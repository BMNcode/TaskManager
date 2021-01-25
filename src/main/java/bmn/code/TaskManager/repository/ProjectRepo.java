package bmn.code.TaskManager.repository;

import bmn.code.TaskManager.model.Project;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProjectRepo extends JpaRepository<Project, Long> {

    Page<Project> findByNumberProjectContaining(String numberProject, Pageable pageable);
}
