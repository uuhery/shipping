package com.company.project.controller.shipping;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.company.project.entity.shipping.Goods;
import com.company.project.service.shipping.GoodsService;
import com.company.project.utilities.utils.DataResult;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;


/**
 *
 *
 * @author wenbin
 * @email *****@mail.com
 * @date 2023-04-16 20:08:24
 */
@Controller
@RequestMapping("/")
public class GoodsController {
    @Resource
    private GoodsService goodsService;
    /**
     * 跳转到页面
     */
    @GetMapping("/index/goods")
    public String goods() {
        return "goods/list";
    }

    @ApiOperation(value = "新增")
    @PostMapping("goods/add")
    @PreAuthorize("hasAuthority('goods:add')")
    @ResponseBody
    public DataResult add(@RequestBody Goods goods){
        goodsService.save(goods);
        return DataResult.success();
    }

    @ApiOperation(value = "删除")
    @DeleteMapping("goods/delete")
    @PreAuthorize("hasAuthority('goods:delete')")
    @ResponseBody
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List<String> ids){
        goodsService.removeByIds(ids);
        return DataResult.success();
    }

    @ApiOperation(value = "更新")
    @PutMapping("goods/update")
    @PreAuthorize("hasAuthority('goods:update')")
    @ResponseBody
    public DataResult update(@RequestBody Goods goods){
        goodsService.updateById(goods);
        return DataResult.success();
    }

    @ApiOperation(value = "查询分页数据")
    @PostMapping("goods/listByPage")
    @PreAuthorize("hasAuthority('goods:list')")
    @ResponseBody
    public DataResult findListByPage(@RequestBody Goods goods){
        LambdaQueryWrapper<Goods> queryWrapper = Wrappers.lambdaQuery();
        //查询条件示例
//        queryWrapper.eq(Goods::getId, goods.getId());
        queryWrapper.orderByAsc(Goods::getId);
        IPage<Goods> iPage = goodsService.page(goods.getQueryPage(), queryWrapper);
        return DataResult.success(iPage);
    }

}
