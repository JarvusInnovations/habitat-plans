const puppeteer = require('puppeteer');
const fileUrl = require('file-url');

const argv = require('yargs')
    .usage('Usage: $0 [input-html-file] [output-pdf-file]')
    .demandCommand(2)
    .boolean('background')
    .default('background', true)
    .default('marginTop', '6.35mm')
    .default('marginRight', '6.35mm')
    .default('marginBottom', '14.11mm')
    .default('marginLeft', '6.35mm')
    .default('format', 'Letter')
    .argv;

async function convert({ htmlPath, pdfPath }) {
    const browser = await puppeteer.launch();
    const page = await browser.newPage();

    await page.goto(fileUrl(htmlPath));

    await page.pdf({
        path: pdfPath,
        format: argv.format,
        printBackground: argv.background,
        margin: {
            top: argv.marginTop,
            right: argv.marginRight,
            bottom: argv.marginBottom,
            left: argv.marginLeft
        }
    });

    await browser.close();
}

(async () => {
    console.log(argv);

    try {
        await convert({
            htmlPath: argv._[0],
            pdfPath: argv._[1]
        });
    } catch (err) {
        console.error('Failed to generate pdf:', err);
        process.exit(1);
    }
})();