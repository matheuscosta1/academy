package br.com.tcc.project.command.customer.mapper;

import br.com.tcc.project.command.RegisterDiscipline;
import br.com.tcc.project.command.mongo.model.DisciplineDocument;
import br.com.tcc.project.controller.request.RegisterDisciplineRequest;
import br.com.tcc.project.controller.response.RegisterDisciplineResponse;
import br.com.tcc.project.domain.Discipline;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface RegisterDisciplineMapper {

  DisciplineDocument map(RegisterDiscipline.Request source);

  }
