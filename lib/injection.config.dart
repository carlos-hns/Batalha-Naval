// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'view_models/insercao_navios_view_model.dart' as _i3;
import 'view_models/jogo_view_model.dart' as _i4;
import 'view_models/pagina_testes_view_model.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.InsercaoNaviosViewModel>(() => _i3.InsercaoNaviosViewModel());
  gh.factory<_i4.JogoViewModel>(() => _i4.JogoViewModel());
  gh.factory<_i5.PaginaTestesViewModel>(() => _i5.PaginaTestesViewModel());
  return get;
}
