
const String js = """
class Controller extends _Controller {
    constructor() {
        super(...arguments);
        this.data = {};
    }
    load(data) {}
    unload() {}
}

globalThis.Controller = Controller;
""";