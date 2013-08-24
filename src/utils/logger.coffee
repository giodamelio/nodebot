Caterpillar = require("caterpillar").Logger
CaterpillarHuman = require("caterpillar-human").Human

logger = new Caterpillar()

logger.pipe(new CaterpillarHuman()).pipe(process.stdout)

module.exports = logger
