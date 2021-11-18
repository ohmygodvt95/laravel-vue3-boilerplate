import {computed} from 'vue';
import {useStore} from 'vuex';

const mapState = (moduleName) => {
  const store = useStore();
  return Object.fromEntries(
    Object.keys(store.state[moduleName]).map((key) => [
      key,
      computed(() => store.state[moduleName][key]),
    ]),
  );
};

const mapGetters = (moduleName) => {
  const store = useStore();
  return Object.fromEntries(
    Object.keys(store.getters)
      .filter((getter) => getter.startsWith(moduleName))
      .map((getter) => [
        getter.replace(moduleName + '/', ''),
        computed(() => store.getters[getter]),
      ]),
  );
};

const mapMutations = (moduleName) => {
  const store = useStore();
  return Object.fromEntries(
    Object.keys(store._mutations)
      .filter((mutation) => mutation.startsWith(moduleName))
      .map((mutation) => {
        return [mutation.replace(moduleName + '/', ''), (value) => store.commit(mutation, value)];
      }),
  );
};

const mapActions = (moduleName) => {
  const store = useStore();
  return Object.fromEntries(
    Object.keys(store._actions)
      .filter((action) => action.startsWith(moduleName))
      .map((action) => [
        action.replace(moduleName + '/', ''),
        (value) => store.dispatch(action, value),
      ]),
  );
};

export {mapState, mapGetters, mapMutations, mapActions};
